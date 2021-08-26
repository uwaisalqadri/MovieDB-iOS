//
//  FavoriteViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit

class FavoriteViewController: UIViewController {

  private let contentView = FavoriteView()

  override func viewWillAppear(_ animated: Bool) {
    setNavigationBar(type: .searchBar)
  }

  override func rightNavigationBarButtonTapped(sender: UIBarButtonItem?) {
    print("Search")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view = contentView
    contentView.tblFavorite.delegate = self
    contentView.tblFavorite.dataSource = self
  }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 7
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 89
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: FavoriteCell = tableView.dequeueReusableCell(for: indexPath)
    return cell
  }

}
