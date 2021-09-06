//
//  SearchViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

  private let contentView = SearchView()
  private let disposeBag = DisposeBag()
  private let viewModel: SearchViewModel
  private let navigator: SearchNavigator

  var searchedMovies = [Movie]()

  init(navigator: SearchNavigator, viewModel: SearchViewModel) {
    self.navigator = navigator
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(_ animated: Bool) {
    setNavigationBar(type: .searchBar)
  }

  override func rightNavigationBarButtonTapped(sender: UIBarButtonItem?) {
    guard let text = contentView.txtSearch.text, text != "" else { return }
    viewModel.searchParam = .init(query: text)
    viewModel.requestSearch()
    contentView.collectionView.reloadData()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view = contentView

    configureView()
    observeValues()
  }

  private func observeValues() {
    contentView.refreshControl.beginRefreshing()
    viewModel.requestSearch()

    viewModel.searchMovies.subscribe(onNext: { [weak self] result in
      self?.contentView.refreshControl.endRefreshing()
      self?.contentView.collectionView.reloadData()
      self?.searchedMovies = result
    }).disposed(by: disposeBag)
  }

  private func configureView() {
    contentView.collectionView.delegate = self
    contentView.collectionView.dataSource = self

    if #available(iOS 10.0, *) {
      contentView.collectionView.refreshControl = contentView.refreshControl
    } else {
      contentView.collectionView.addSubview(contentView.refreshControl)
    }

    let leftItem = UIBarButtonItem(customView: contentView.txtSearch)
    navigationItem.leftBarButtonItem = leftItem

    contentView.txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    contentView.refreshControl.addTarget(self, action: #selector(onPullToRefresh(_:)), for: .valueChanged)
  }

  @objc func textFieldDidChange(_ sender: UITextField) {
    contentView.refreshControl.beginRefreshing()
    guard let text = sender.text, text != "" else { return }
    viewModel.searchParam = .init(query: text)
    viewModel.requestSearch()
  }

  @objc func onPullToRefresh(_ sender: Any) {
    viewModel.requestSearch()
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
}
