//
//  HomeViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class HomeViewController: UIViewController {

  private let homeView = HomeView()
  private let navigator: HomeNavigator
  private let viewModel: HomeViewModel
  private let disposeBag = DisposeBag()
  private var popularMovies = [Movie]()
  private var upComingMovies = [Movie]()

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

    if #available(iOS 10.0, *) {
      homeView.tableView.refreshControl = homeView.refreshControl
    } else {
      homeView.tableView.addSubview(homeView.refreshControl)
    }
    homeView.refreshControl.addTarget(self, action: #selector(onPullToRefresh(_:)), for: .valueChanged)

    observeValues()
    reloadHomeData()
  }

  @objc func onPullToRefresh(_ sender: Any) {
    reloadHomeData()
  }


  private func observeValues() {
    homeView.refreshControl.beginRefreshing()

    viewModel.popularMovies.subscribe(onNext: { [weak self] result in
      self?.popularMovies = result
      self?.homeView.tableView.reloadData()
      self?.homeView.refreshControl.endRefreshing()
    }).disposed(by: disposeBag)

    viewModel.upComingMovies.subscribe(onNext: { [weak self] result in
      self?.upComingMovies = result
      self?.homeView.tableView.reloadData()
      self?.homeView.refreshControl.endRefreshing()
    }).disposed(by: disposeBag)
  }

  private func reloadHomeData() {
    viewModel.requestPopularMovie()
    viewModel.requestUpComingMovie()
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
      cell.movies = popularMovies
      cell.movieClickHandler = { movie in
        print("click", movie)
      }
      return cell
    case .upcoming:
      let cell: HomeViewCell = tableView.dequeueReusableCell(for: indexPath)
      cell.lblCategory.text = "Coming Soon"
      cell.movies = upComingMovies
      cell.movieClickHandler = { movie in
        print("click", movie)
      }
      return cell
    case .banner:
      let cell: HomeBannerViewCell = tableView.dequeueReusableCell(for: indexPath)
      cell.selectionStyle = .none
      cell.bannerMovies = popularMovies
      cell.bannerClickHandler = { movie in
        print("click", movie)
      }
      return cell
    }
  }

}
