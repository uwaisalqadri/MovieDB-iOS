//
//  PopularViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit

class PopularViewController: UIViewController {

  private let contentView = PopularView()

  override func viewWillAppear(_ animated: Bool) {
    setNavigationBar(type: .searchBar)
  }

  override func rightNavigationBarButtonTapped(sender: UIBarButtonItem?) {
    print("Search")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view = contentView
    contentView.tableView.delegate = self
    contentView.tableView.dataSource = self
  }
}

extension PopularViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: PopularCell = tableView.dequeueReusableCell(for: indexPath)
    return cell
  }


}
