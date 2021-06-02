//
//  FavoriteViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteViewController: UIViewController {

  private var viewModel: FavoriteViewModel
  private let bag = DisposeBag()

  init(viewModel: FavoriteViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

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
      string: "Search..",
      attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
    )
  }

  private let favoriteList = configure(UITableView()) {
    $0.backgroundColor = UIColor(named: "BackgroundColor")
    $0.rowHeight = 130
    $0.register(FavoriteCell.self, forCellReuseIdentifier: "favCell")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    addLayoutAndSubViews()
    bindFavoriteList()

    favoriteList.rx.setDelegate(self).disposed(by: bag)

    viewModel.favMovies.subscribe(onDisposed:  {
      self.favoriteList.reloadData()
    }).disposed(by: bag)
  }
}

extension FavoriteViewController: UITableViewDelegate {

  func bindFavoriteList() {
    viewModel.favMovies.bind(to: favoriteList.rx.items(cellIdentifier: "favCell", cellType: FavoriteCell.self)) { (row, item, cell) in
      cell.set(movie: item)
    }.disposed(by: bag)

    favoriteList.rx.modelSelected(Movie.self).subscribe(onNext: { item in
      //self.showDetail(idMovie: item.id)
    }).disposed(by: bag)

    viewModel.getFavoriteMovie()
  }

  /// need to seperate in navigator
//  func showDetail(idMovie: Int) {
//    let vc = DetailViewController(idMovie: idMovie)
//    vc.modalPresentationStyle = .fullScreen
//    self.present(vc, animated: true)
//  }

}

extension FavoriteViewController {

  func addLayoutAndSubViews() {
    view.backgroundColor = UIColor(named: "BackgroundColor")

    [searchField ,searchIcon].forEach { navBar.addSubview($0) }

    [navBar, favoriteList].forEach { view.addSubview($0) }

    navBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: view.width, height: 125))

    searchField.anchor(top: navBar.safeAreaLayoutGuide.topAnchor, leading: navBar.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 20, bottom: 0, right: 50), size: .init(width: view.width-20, height: 20))

    searchIcon.anchor(top: navBar.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: navBar.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 20), size: .init(width: 20, height: 20))

    favoriteList.anchor(top: navBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
  }
}
