//
//  FavoriteViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import RxSwift

class FavoriteViewController: UIViewController {

  @IBOutlet weak var tblFavorite: UITableView!

  private let navigator: FavoriteNavigator
  let viewModel: FavoriteViewModel

  private var favoriteMovies = [Movie]()
  private let disposeBag = DisposeBag()

  let refreshControl = UIRefreshControl()

  lazy var txtSearch: UITextField = {
    return UITextField(frame: .init(x: 0, y: 0, width: 300, height: 50)).apply { (searchBar) in
      searchBar.textColor = .white
      searchBar.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray as Any])
      searchBar.tintColor = .accentColor
      searchBar.autocorrectionType = .no
      searchBar.autocapitalizationType = .none
    }
  }()

  init(navigator: FavoriteNavigator, viewModel: FavoriteViewModel) {
    self.navigator = navigator
    self.viewModel = viewModel
    super.init(nibName: String(describing: FavoriteViewController.self), bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(_ animated: Bool) {
    setNavigationBar(type: .searchBar)
    viewModel.requestFavoriteMovie()
    tblFavorite.reloadData()
  }

  override func rightNavigationBarButtonTapped(sender: UIBarButtonItem?) {
//    guard let text = txtSearch.text, text != "" else { return }
//    viewModel.query = text
    viewModel.requestFavoriteMovie()
    tblFavorite.reloadData()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    observeValues()
  }

  private func observeValues() {
    refreshControl.beginRefreshing()

    viewModel.favoriteMovies.subscribe(onNext: { [weak self] result in
      self?.favoriteMovies = result
      self?.refreshControl.endRefreshing()
      self?.tblFavorite.reloadData()
    }).disposed(by: disposeBag)
  }

  private func configureViews() {
    tblFavorite.delegate = self
    tblFavorite.dataSource = self
    tblFavorite.register(cellType: FavoriteCell.self)

    if #available(iOS 10.0, *) {
      tblFavorite.refreshControl = refreshControl
    } else {
      tblFavorite.addSubview(refreshControl)
    }

    let leftItem = UIBarButtonItem(customView: txtSearch)
    navigationItem.leftBarButtonItem = leftItem

    txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    refreshControl.addTarget(self, action: #selector(onPullToRefresh(_:)), for: .valueChanged)
  }

  @objc func textFieldDidChange(_ sender: UITextField) {
    refreshControl.beginRefreshing()
//    guard let text = sender.text else { return }
//    viewModel.query = text
    viewModel.requestFavoriteMovie()
  }

  @objc func onPullToRefresh(_ sender: Any) {
    viewModel.requestFavoriteMovie()
  }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoriteMovies.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: FavoriteCell = tableView.dequeueReusableCell(for: indexPath)
    cell.movie = favoriteMovies[indexPath.row]
    cell.selectionStyle = .none

    cell.removeHandler = { [weak self] movie in
      guard let self = self else { return }
//      self.viewModel.removeFavoriteMovie(idMovie: movie.id as? Int ?? 0)
      self.viewModel.requestFavoriteMovie()
      self.tblFavorite.reloadData()
    }

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigator.navigateToDetail(from: self, with: favoriteMovies[indexPath.row].id as? Int ?? 0)
  }

}
