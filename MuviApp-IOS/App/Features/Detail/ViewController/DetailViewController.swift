//
//  DetailViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var imgPoster: UIImageView!
  @IBOutlet weak var clCast: UICollectionView!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblDate: UILabel!
  @IBOutlet weak var lblGenre: UILabel!
  @IBOutlet weak var lblOverview: UILabel!
  @IBOutlet weak var btnFavorite: UIButton!
  @IBOutlet weak var scrollDetail: UIScrollView!

  private let refreshControl = UIRefreshControl()

  private let navigator: DetailNavigator
  private let viewModel: DetailViewModel

  init(navigator: DetailNavigator, viewModel: DetailViewModel) {
    self.navigator = navigator
    self.viewModel = viewModel
    super.init(nibName: "DetailViewController", bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

//  override func viewWillAppear(_ animated: Bool) {
//    setNavigationBar(type: .backTransparent)
//  }
//
//  override func leftNavigationBarButtonTapped(sender: UIBarButtonItem?) {
//    navigationController?.popViewController(animated: true)
//  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
    observeValues()
  }

  private func observeValues() {
    scrollDetail.refreshControl?.beginRefreshing()
    viewModel.requestDetail()
  }

  private func configureViews() {
    clCast.delegate = self
    clCast.dataSource = self
    clCast.register(cellType: CastCell.self)

    if #available(iOS 10.0, *) {
      scrollDetail.refreshControl = refreshControl
    } else {
     scrollDetail.addSubview(refreshControl)
    }
    refreshControl.addTarget(self, action: #selector(onPullToRefresh(_:)), for: .valueChanged)

    btnFavorite.layer.borderColor = UIColor.lightGray.cgColor

//    lblTitle.text = movie?.title
//    lblDate.text = movie?.releaseDate
//    lblGenre.text = movie?.releaseDate
//    lblOverview.text = movie?.overview
  }

  @objc func onPullToRefresh(_ sender: Any) {
    viewModel.requestDetail()
  }

  @IBAction func didTapWatchTrailer(_ sender: Any) {
    print("watch")
  }

  @IBAction func didTapFavorite(_ sender: Any) {
    print("favorite")
  }
}


extension DetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CastCell = collectionView.dequeueReusableCell(for: indexPath)
    return cell
  }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 200, height: 200)
  }

}
