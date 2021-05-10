//
//  HomeViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import UIKit
import FSPagerView
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
    
    private let pagerView = configure(FSPagerView()) {
        $0.isInfinite = true
        $0.automaticSlidingInterval = 3.0
        $0.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "bannerCell")
    }
    
    private let pagerControl = FSPageControl()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLayoutAndSubViews()
        bindPopularList()
        bindUpComingList()
                                
        pagerView.dataSource = self
        pagerView.delegate = self
        
        popularList.rx.setDelegate(self).disposed(by: bag)
        upComingList.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.loadingState.observe { result in
            result == true ? self.progress.show(in: self.view) : self.progress.dismiss()
        }
    }
    
}

extension HomeViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 5
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "bannerCell", at: index)
        cell.imageView?.sd_setImage(with: URL(string: "\(Constants.urlImage)/oBgWY00bEFeZ9N25wWVyuQddbAo.jpg"))
        cell.imageView?.contentMode = .scaleAspectFill
        return cell
    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func bindPopularList() {
        viewModel.popularMovies.bind(to: popularList.rx.items(cellIdentifier: "popularCell", cellType: PopularCell.self)) { (row, item, cell) in
            cell.set(movie: item)
        }.disposed(by: bag)
        
        popularList.rx.modelSelected(Movie.self).subscribe(onNext: { item in
            print("selected popular: \(item)")
            let vc = DetailViewController(idGame: item.id)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
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
        }).disposed(by: bag)
        
        viewModel.getUpComingMovies(year: "2022")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == upComingList {
            return CGSize(width: collectionView.width/2.5, height: collectionView.width/2)
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

        // pagerControl.anchorSize(to: pagerView)
        
        popularLabel.anchor(top: pagerView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: popularList.topAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 15, left: 10, bottom: 15, right: 10), size: .init(width: scrollView.width, height: 23))
        
        popularList.anchor(top: popularLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: upComingLabel.topAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 8, left: 10, bottom: 35, right: 0), size: .init(width: scrollView.width, height: 200))
        
        upComingLabel.anchor(top: popularList.bottomAnchor, leading: scrollView.leadingAnchor, bottom: upComingList.topAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 15, left: 10, bottom: 15, right: 10), size: .init(width: scrollView.width, height: 23))
        
        upComingList.anchor(top: upComingLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 20, right: 0), size: .init(width: scrollView.width, height: 200))
    }
}
