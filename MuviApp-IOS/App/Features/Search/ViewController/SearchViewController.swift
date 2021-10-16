//
//  SearchViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 05/10/21.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

  @IBOutlet weak var clSearch: UICollectionView!
  @IBOutlet weak var lblSearched: UILabel!
  @IBOutlet weak var lblDescSearch: UILabel!

  private let disposeBag = DisposeBag()
  private let viewModel: SearchViewModel
  private let navigator: SearchNavigator

  private var searchedMovies = [Movie]()

  private let refreshControl = UIRefreshControl()

  lazy var txtSearch: UITextField = {
    return UITextField(frame: .init(x: 0, y: 0, width: 300, height: 50)).apply { (searchBar) in
      searchBar.textColor = .white
      searchBar.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray as Any])
      searchBar.tintColor = .accentColor
      searchBar.autocorrectionType = .no
      searchBar.autocapitalizationType = .none
    }
  }()

  init(navigator: SearchNavigator, viewModel: SearchViewModel) {
    self.navigator = navigator
    self.viewModel = viewModel
    super.init(nibName: String(describing: SearchViewController.self), bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(_ animated: Bool) {
    setNavigationBar(type: .searchBar)
    viewModel.requestSearch()
    clSearch.reloadData()
  }

  override func rightNavigationBarButtonTapped(sender: UIBarButtonItem?) {
    guard let text = txtSearch.text, text != "" else { return }
    viewModel.searchParam = .init(query: text)
    viewModel.requestSearch()
    clSearch.reloadData()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    observeValues()
  }

  private func observeValues() {
    refreshControl.beginRefreshing()
    viewModel.requestSearch()

    viewModel.searchMovies.subscribe(onNext: { [weak self] result in
      self?.refreshControl.endRefreshing()
      self?.clSearch.reloadData()
      self?.searchedMovies = result
    }).disposed(by: disposeBag)
  }

  private func configureView() {
    clSearch.delegate = self
    clSearch.dataSource = self
    clSearch.register(cellType: SearchCell.self)
    txtSearch.delegate = self

    if #available(iOS 10.0, *) {
      clSearch.refreshControl = refreshControl
    } else {
      clSearch.addSubview(refreshControl)
    }

    let leftItem = UIBarButtonItem(customView: txtSearch)
    navigationItem.leftBarButtonItem = leftItem

    txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    refreshControl.addTarget(self, action: #selector(onPullToRefresh(_:)), for: .valueChanged)
  }

  @objc func textFieldDidChange(_ sender: UITextField) {
    refreshControl.beginRefreshing()
    guard let text = sender.text, text != "" else { return }
    lblSearched.text = "'\(text)'"
    viewModel.searchParam = .init(query: text)
    viewModel.requestSearch()
  }

  @objc func onPullToRefresh(_ sender: Any) {
    viewModel.requestSearch()
  }
}

extension SearchViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    lblSearched.isHidden = false
    lblDescSearch.isHidden = false
  }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 2.2, height: 270)
  }
}

extension SearchViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return searchedMovies.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: SearchCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.movie = searchedMovies[indexPath.row]
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    navigator.navigateToDetail(from: self, with: searchedMovies[indexPath.row].id ?? 0)
  }
}
