//
//  HomeViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import UIKit
import RxSwift
import RxCocoa
import JGProgressHUD

class HomeViewController: UIViewController {
    
    private var viewModel = HomeViewModel(movieUseCase: Injection.init().provideHome())
    
    private let bag = DisposeBag()
    
    private let progress = JGProgressHUD(style: .dark)
    
    private let scrollView = configure(UIScrollView()) {
        $0.isScrollEnabled = true
        $0.isUserInteractionEnabled = true
    }
    
    private let navBar = configure(UIStackView()) {
        $0.backgroundColor = UIColor(named: "BrandColor")
    }
    
    private let notifIcon = configure(UIImageView()) {
        $0.image = UIImage(named: "NotifIcon")
    }
    
    private let appIcon = configure(UIImageView()) {
        $0.image = UIImage(named: "MovieDB")
        $0.contentMode = .scaleAspectFit
    }
    
    private let pagerView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "bannerCell")
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    private let pagerControl = configure(UIPageControl()) {
        $0.numberOfPages = 3
        $0.currentPage = 0
    }
    
    private let popularLabel = configure(UILabel()) {
        $0.text = "Popular Movies"
        $0.textAlignment = .left
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    private let popularList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: "popularCell")
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        return collectionView
    }()
    
    private let upComingLabel = configure(UILabel()) {
        $0.text = "Coming Soon"
        $0.textAlignment = .left
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    private let upComingList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UpComingCell.self, forCellWithReuseIdentifier: "upcomingCell")
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        return collectionView
    }()
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLayoutAndSubViews()
        bindPagerList()
        bindPopularList()
        bindUpComingList()
                                
        pagerView.rx.setDelegate(self).disposed(by: bag)
        popularList.rx.setDelegate(self).disposed(by: bag)
        upComingList.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.loadingState.observe { result in
            result == true ? self.progress.show(in: self.view) : self.progress.dismiss()
        }
        
        viewModel.popularMovies.subscribe(onNext: { item in
            print("oke \(item)")
        }).disposed(by: bag)
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func bindPagerList() {
        viewModel.popularMovies.bind(to: pagerView.rx.items(cellIdentifier: "bannerCell", cellType: BannerCell.self)) {
            (row, item, cell) in
            cell.set(movie: item)
        }.disposed(by: bag)
        
        pagerView.rx.modelSelected(Movie.self).subscribe(onNext: { item in
            print("banner \(item)")
            self.showDetail(idGame: item.id)
        }).disposed(by: bag)
    }
    
    func bindPopularList() {
        viewModel.popularMovies.bind(to: popularList.rx.items(cellIdentifier: "popularCell", cellType: PopularCell.self)) { (row, item, cell) in
            cell.set(movie: item)
        }.disposed(by: bag)
        
        popularList.rx.modelSelected(Movie.self).subscribe(onNext: { item in
            print("selected popular: \(item)")
            self.showDetail(idGame: item.id)
        }).disposed(by: bag)
        
        viewModel.getDiscoverMovies(year: "2021")
    }
    
    func bindUpComingList() {
        viewModel.upComingMovies.bind(to: upComingList.rx.items(cellIdentifier: "upcomingCell", cellType: UpComingCell.self)) {
            (row, item, cell) in
            cell.set(movie: item)
        }.disposed(by: bag)
        
        upComingList.rx.modelSelected(Movie.self).subscribe(onNext: { item in
            print("selected upcoming \(item)")
            self.showDetail(idGame: item.id)
        }).disposed(by: bag)
        
        viewModel.getUpComingMovies(year: "2022")
    }

    func showDetail(idGame: Int) {
        let vc = DetailViewController(idGame: idGame)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = pagerView.frame.size
        if collectionView == upComingList {
            return CGSize(width: collectionView.width/2.5, height: collectionView.width/2)
        } else if collectionView == pagerView {
            return CGSize(width: scrollView.width, height: size.height)
        }
        return CGSize(width: collectionView.width/2.5, height: collectionView.width/2)
    }
}

extension HomeViewController {
    func addLayoutAndSubViews() {
        view.backgroundColor = UIColor(named: "BrandColor")
        view.addSubview(scrollView)
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 2)
        scrollView.frame = view.bounds
        
        [notifIcon, appIcon].forEach { navBar.addSubview($0) }

        [navBar, pagerView, pagerControl, popularLabel, popularList, upComingList, upComingLabel].forEach { scrollView.addSubview($0) }
        
        scrollView.anchorSize(to: view)
        
        navBar.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: pagerView.topAnchor, trailing: scrollView.trailingAnchor, size: .init(width: scrollView.width, height: 95))
        
        appIcon.anchor(top: navBar.safeAreaLayoutGuide.topAnchor, leading: navBar.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 20, bottom: 0, right: 0), size: .init(width: 100, height: 20))
        
        notifIcon.anchor(top: navBar.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: navBar.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 20), size: .init(width: 20, height: 20))
        
        pagerView.anchor(top: navBar.bottomAnchor, leading: scrollView.leadingAnchor, bottom: popularLabel.topAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 45, right: 0), size: .init(width: scrollView.width, height: 300))

        pagerControl.anchor(top: nil, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: nil)
        
        popularLabel.anchor(top: pagerView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: popularList.topAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 15, left: 10, bottom: 15, right: 10), size: .init(width: scrollView.width, height: 23))
        
        popularList.anchor(top: popularLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: upComingLabel.topAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 8, left: 10, bottom: 35, right: 0), size: .init(width: scrollView.width, height: 200))
        
        upComingLabel.anchor(top: popularList.bottomAnchor, leading: scrollView.leadingAnchor, bottom: upComingList.topAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 15, left: 10, bottom: 15, right: 10), size: .init(width: scrollView.width, height: 23))
        
        upComingList.anchor(top: upComingLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 20, right: 0), size: .init(width: scrollView.width, height: 200))
    }
}
