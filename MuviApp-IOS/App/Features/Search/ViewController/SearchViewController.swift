//
//  SearchViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit

class SearchViewController: UIViewController {

  private let contentView = SearchView()

  override func viewWillAppear(_ animated: Bool) {
    setNavigationBar(type: .searchBar)
  }

  override func rightNavigationBarButtonTapped(sender: UIBarButtonItem?) {
    print("Search")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view = contentView
    contentView.collectionView.delegate = self
    contentView.collectionView.dataSource = self
  }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 2.2, height: 270)
  }
}

extension SearchViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: SearchCell = collectionView.dequeueReusableCell(for: indexPath)
    return cell
  }
}
