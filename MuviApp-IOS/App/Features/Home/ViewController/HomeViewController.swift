//
//  HomeViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 05/10/21.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD
import SDWebImage

class HomeViewController: UIViewController {

  @IBOutlet weak var tblHome: UITableView!

  private let navigator: HomeNavigator
  private let viewModel: HomeViewModel

  private let disposeBag = DisposeBag()

  private var popularMovies = [Movie]()
  private var upComingMovies = [Movie]()
  private var bannerMovies = [Movie]()

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

  let refreshControl = UIRefreshControl()

  init(navigator: HomeNavigator, viewModel: HomeViewModel) {
    self.navigator = navigator
    self.viewModel = viewModel
    super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(_ animated: Bool) {
    setNavigationBar(type: .logoAndIcon)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    observeValues()
    reloadHomeData()
  }

  @objc func onPullToRefresh(_ sender: Any) {
    reloadHomeData()
  }

  private func configureViews() {
    tblHome.delegate = self
    tblHome.dataSource = self
    tblHome.tableFooterView = UIView()
    tblHome.backgroundColor = .backgroundColor
    tblHome.register(cellType: HomeCell.self)
    tblHome.register(cellType: HomeBannerCell.self)

    if #available(iOS 10.0, *) {
      tblHome.refreshControl = refreshControl
    } else {
      tblHome.addSubview(refreshControl)
    }
    refreshControl.addTarget(self, action: #selector(onPullToRefresh(_:)), for: .valueChanged)
  }

  private func observeValues() {
    refreshControl.beginRefreshing()

    viewModel.popularMovies.subscribe(onNext: { [weak self] result in
      self?.popularMovies = result
      self?.didFinish()
    }).disposed(by: disposeBag)

    viewModel.upComingMovies.subscribe(onNext: { [weak self] result in
      self?.upComingMovies = result
      self?.didFinish()
    }).disposed(by: disposeBag)

    viewModel.bannerMovies.subscribe(onNext: { [weak self] result in
      self?.bannerMovies = result
      self?.didFinish()
    }).disposed(by: disposeBag)
  }

  private func reloadHomeData() {
    viewModel.requestPopularMovie()
    viewModel.requestUpComingMovie()
    viewModel.requestBannerMovie()
  }

  private func didFinish() {
    tblHome.reloadData()
    refreshControl.endRefreshing()
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
      let cell: HomeCell = tableView.dequeueReusableCell(for: indexPath)
      cell.lblCategory.text = "Popular"
      cell.movies = popularMovies
      cell.selectionStyle = .none
      cell.movieClickHandler = { [weak self] movie in
        guard let self = self else { return }
        self.navigator.navigateToDetail(from: self, with: movie.id ?? 0)
      }
      return cell
    case .upcoming:
      let cell: HomeCell = tableView.dequeueReusableCell(for: indexPath)
      cell.lblCategory.text = "Coming Soon"
      cell.movies = upComingMovies
      cell.selectionStyle = .none
      cell.movieClickHandler = { [weak self] movie in
        guard let self = self else { return }
        self.navigator.navigateToDetail(from: self, with: movie.id ?? 0)
      }
      return cell
    case .banner:
      let cell: HomeBannerCell = tableView.dequeueReusableCell(for: indexPath)
      cell.selectionStyle = .none
      cell.bannerMovies = bannerMovies
      cell.bannerClickHandler = { [weak self] movie in
        guard let self = self else { return }
        self.navigator.navigateToDetail(from: self, with: movie.id ?? 0)
      }
      return cell
    }
  }

}

