//
//  HomeViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit

class HomeViewController: UIViewController {

  override func viewWillAppear(_ animated: Bool) {
    setNavigationBar(type: .logoAndIcon)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    let homeView = HomeView()
    view = homeView
    homeView.tableView.delegate = self
    homeView.tableView.dataSource = self
  }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: HomeViewCell = tableView.dequeueReusableCell(for: indexPath)
    cell.lblMovie.text = "Hello World"
    return cell
  }
}
