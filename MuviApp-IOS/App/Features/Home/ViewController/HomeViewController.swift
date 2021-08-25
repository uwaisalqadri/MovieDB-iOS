//
//  HomeViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit

class HomeViewController: UIViewController {

  private let homeView = HomeView()

  private enum HomeTableSection {
    case banner
    case popular
    case upcoming
  }

  private let allSection: [HomeTableSection] = [
    .banner,
    .popular,
    .upcoming
  ]

  override func viewWillAppear(_ animated: Bool) {
    setNavigationBar(type: .logoAndIcon)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view = homeView
    homeView.tableView.delegate = self
    homeView.tableView.dataSource = self
  }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    allSection.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: HomeBannerViewCell = tableView.dequeueReusableCell(for: indexPath)
    cell.selectionStyle = .none

    switch allSection[indexPath.section] {
    case .popular:
      let cell: HomeViewCell = tableView.dequeueReusableCell(for: indexPath)
      cell.lblCategory.text = "Popular"
      return cell
    case .upcoming:
      let cell: HomeViewCell = tableView.dequeueReusableCell(for: indexPath)
      cell.lblCategory.text = "Coming Soon"
      return cell
    default:
      break
    }

    return cell
  }
}
