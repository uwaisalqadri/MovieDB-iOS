//
//  DetailViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 10/16/21.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import SafariServices

class DetailViewController: UIViewController {

  @IBOutlet weak var imgPoster: UIImageView!
  @IBOutlet weak var clCast: UICollectionView!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblDate: UILabel!
  @IBOutlet weak var lblGenre: UILabel!
  @IBOutlet weak var lblOverview: UILabel!
  @IBOutlet weak var btnFavorite: UIButton!
  @IBOutlet weak var scrollDetail: UIScrollView!

  private let navigator: DetailNavigator
  private let viewModel: DetailViewModel
//  private let favoriteViewModel: FavoriteViewModel

  private let disposeBag = DisposeBag()
  private var isFavorite = false

  private var credits = [Credit]()
  private var videos = [Video]()

  var movie: Movie? {
    didSet {
      configureViews()
//      observeValues()
    }
  }

  init(navigator: DetailNavigator, viewModel: DetailViewModel) {
    self.navigator = navigator
    self.viewModel = viewModel
//    self.favoriteViewModel = favoriteViewModel
    super.init(nibName: String(describing: DetailViewController.self), bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(_ animated: Bool) {
    setNavigationBar(type: .backTransparent)
  }

  override func leftNavigationBarButtonTapped(sender: UIBarButtonItem?) {
    navigationController?.popViewController(animated: true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    observeValues()
  }

  private func observeValues() {
    showLoading()
    reloadDetail()

    viewModel.detailMovie.subscribe(onNext: { [weak self] result in
      self?.movie = result
      self?.didFinish()
//      self?.favoriteViewModel.checkFavoriteMovie(idMovie: result.id as? Int ?? 0)
    }).disposed(by: disposeBag)

    viewModel.creditMovie.subscribe(onNext: { [weak self] result in
      self?.credits = result
      self?.didFinish()
    }).disposed(by: disposeBag)

    viewModel.videoMovie.subscribe(onNext: { [weak self] result in
      self?.videos = result
      self?.didFinish()
    }).disposed(by: disposeBag)

//    favoriteViewModel.favoriteState.subscribe(onNext: { [weak self] state in
//      switch state {
//      case .favMovieFound(let state):
//        self?.toggleButton(state: state)
//      case .addFavorite:
//        self?.toggleButton(state: true)
//      case .removeFavorite:
//        self?.toggleButton(state: false)
//      }
//    }).disposed(by: disposeBag)

  }

  private func configureViews() {
    clCast.delegate = self
    clCast.dataSource = self
    clCast.register(cellType: CastCell.self)

    btnFavorite.layer.borderColor = UIColor.lightGray.cgColor
    scrollDetail.contentInsetAdjustmentBehavior = .never

    var genreNames = [String]()
    imgPoster.sd_imageIndicator = SDWebImageActivityIndicator.medium
    imgPoster.sd_setImage(with: URL(string: Constants.imgUrl + (movie?.posterPath ?? "")))
    lblTitle.text = movie?.title
    lblDate.text = movie?.releaseDate?.formatDate()
    lblOverview.text = movie?.overview
    movie?.genres?.forEach { genre in genreNames.append(genre.name ?? "") }
    lblGenre.text = genreNames.joined(separator: ", ")
  }

  private func reloadDetail() {
    viewModel.requestDetailMovie()
    viewModel.requestCreditMovie()
  }

  private func didFinish() {
    hideLoading()
    clCast.reloadData()
  }

  @objc func onPullToRefresh(_ sender: Any) {
    reloadDetail()
  }

  @IBAction func didTapWatchTrailer(_ sender: Any) {
    videos.forEach { video in
      guard let url = URL(string: Constants.youtubeUrl + (video.key ?? "")) else { return }
      present(SFSafariViewController(url: url), animated: true, completion: nil)
    }
  }

  @IBAction func didTapFavorite(_ sender: Any) {
//    guard let favoriteMovie = movie else { return }
//    isFavorite
//      ? favoriteViewModel.removeFavoriteMovie(idMovie: Int(truncating: (favoriteMovie.id ?? 0)))
//      : favoriteViewModel.addFavoriteMovie(movie: favoriteMovie)
  }

//  private func toggleButton(state: Bool) {
//    isFavorite = state
//    btnFavorite.setTitle(state ? "Remove Favorite" : "Add to Favorite", for: .normal)
//    if #available(iOS 13.0, *) {
//      btnFavorite.setImage(state ? UIImage(systemName: "checkmark") : .iconAdd, for: .normal)
//      btnFavorite.tintColor = .accentColor
//    }
//  }
}


extension DetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return credits.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CastCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.credit = credits[indexPath.row]
    return cell
  }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width/3.6, height: collectionView.frame.height)
  }

}

