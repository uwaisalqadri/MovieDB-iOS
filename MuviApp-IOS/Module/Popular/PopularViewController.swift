//
//  PopularViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import UIKit
import RxSwift
import RxCocoa
import JGProgressHUD

class PopularViewController: UIViewController {
    
    private var viewModel = PopularViewModel(popularUseCase: Injection.init().provideSearch())
    
    private let bag = DisposeBag()
    
    private let progress = JGProgressHUD(style: .dark)
    
    private let navBar = configure(UIStackView()) {
        $0.backgroundColor = UIColor(named: "BrandColor")
    }
    
    private let searchIcon = configure(UIImageView()) {
        $0.image = UIImage(named: "SearchIcon")
    }
    
    private let searchField = configure(UITextField()) {
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.textColor = .white
        $0.attributedPlaceholder = NSAttributedString(
            string: "Search Movies...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
    }
    
    private let beforeSearchedText = configure(UILabel()) {
        $0.text = "Showing Result of"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 18)
    }
    
    private let searchedText = configure(UILabel()) {
        $0.text = "'Naruto'"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    private let movieList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 256)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PopularSearchCell.self, forCellWithReuseIdentifier: "movieCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLayoutAndSubViews()
        bindResultList()
        movieList.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.loadingState.observe { result in
            result == true ? self.progress.show(in: self.view) : self.progress.dismiss()
        }
    }
    
}

extension PopularViewController: UICollectionViewDelegateFlowLayout {
    
    func bindResultList() {
        viewModel.movies.bind(to: movieList.rx.items(cellIdentifier: "movieCell", cellType: PopularSearchCell.self)) {
            (row, item, cell) in
            cell.set(movie: item)
        }.disposed(by: bag)
        
        movieList.rx.modelSelected(PopularSearchCell.self).subscribe(onNext: { item in
            print("selected result \(item)")
        }).disposed(by: bag)
        
        viewModel.searchMovies(query: "naruto")
    }
}

extension PopularViewController {
    
    func addLayoutAndSubViews() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        movieList.backgroundColor = UIColor(named: "BackgroundColor")
        movieList.frame = view.bounds

        [searchIcon, searchField].forEach { navBar.addSubview($0) }

        [navBar, movieList, beforeSearchedText, searchedText].forEach { view.addSubview($0) }
        
        navBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: view.width, height: 125))
        
        searchField.anchor(top: navBar.safeAreaLayoutGuide.topAnchor, leading: navBar.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 20, bottom: 0, right: 50), size: .init(width: view.width-20, height: 20))
        
        searchIcon.anchor(top: navBar.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: navBar.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 20), size: .init(width: 20, height: 20))
        
        beforeSearchedText.anchor(top: navBar.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 24, left: 25, bottom: 0, right: 0))
        
        searchedText.anchor(top: navBar.bottomAnchor, leading: beforeSearchedText.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 24, left: 5, bottom: 0, right: 0))
                
        movieList.anchor(top: beforeSearchedText.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 24, left: 25, bottom: 0, right: 25))
        
            
    }
    
}
