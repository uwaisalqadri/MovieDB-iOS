//
//  HomeViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

  private let homeView = HomeView()
  private let navigator: HomeNavigator
  private let viewModel: HomeViewModel
  private let disposeBag = DisposeBag()

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

  init(navigator: HomeNavigator, viewModel: HomeViewModel) {
    self.navigator = navigator
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(_ animated: Bool) {
    setNavigationBar(type: .logoAndIcon)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view = homeView
    homeView.tableView.delegate = self
    homeView.tableView.dataSource = self

    observeValues()
  }


  private func observeValues() {
    showLoading()
    viewModel.requestDiscoverMovie()

    viewModel.discoverMovie.subscribe(onNext: { result in
      print("vc", result)
      self.hideLoading()
    }).disposed(by: disposeBag)
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

    switch allSection[indexPath.section] {
    case .popular:
      let cell: HomeViewCell = tableView.dequeueReusableCell(for: indexPath)
      cell.lblCategory.text = "Popular"
      cell.movieClickHandler = { movie in
        print("click", movie)
      }
      return cell
    case .upcoming:
      let cell: HomeViewCell = tableView.dequeueReusableCell(for: indexPath)
      cell.lblCategory.text = "Coming Soon"
      cell.movieClickHandler = { movie in
        print("click", movie)
      }
      return cell
    case .banner:
      let cell: HomeBannerViewCell = tableView.dequeueReusableCell(for: indexPath)
      cell.selectionStyle = .none
      cell.bannerClickHandler = {
        self.navigator.navigateToDetail(from: self)
      }
      return cell
    }
  }

}
