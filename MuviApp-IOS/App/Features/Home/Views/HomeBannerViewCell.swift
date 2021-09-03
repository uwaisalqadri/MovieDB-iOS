//
//  HomeBannerViewCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import Reusable

class HomeBannerViewCell: UITableViewCell, Reusable {

  lazy var collectionView: UICollectionView = {

    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0

    return UICollectionView(frame: .zero, collectionViewLayout: layout).apply {
      $0.allowsMultipleSelection = false
      $0.showsVerticalScrollIndicator = false
      $0.showsHorizontalScrollIndicator = false
      $0.backgroundColor = .backgroundColor
      $0.isPagingEnabled = true
      $0.delegate = self
      $0.dataSource = self
      $0.register(cellType: HomeBannerCollectionViewCell.self)
    }
  }()

  lazy var pageControl: UIPageControl = {
    return UIPageControl().apply { control in
      control.currentPageIndicatorTintColor = .accentColor
    }
  }()

  var bannerClickHandler: ((Movie) -> Void)?
  var bannerMovies: [Movie]? {
    didSet {
      collectionView.reloadData()
      pageControl.numberOfPages = bannerMovies?.count ?? 0
    }
  }

  override func layoutSubviews() {
    configureViews()
  }

  private func configureViews() {

    subviews {
      collectionView
      pageControl
    }

    collectionView.pin
      .all()

    pageControl.pin
      .horizontally()
      .bottom(15)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.size(size)
    configureViews()
    return CGSize(width: frame.width, height: 230)
  }
}

extension HomeBannerViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.size.height)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    bannerClickHandler?(bannerMovies?[indexPath.row] as! Movie)
  }
}

extension HomeBannerViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return bannerMovies?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: HomeBannerCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.movie = bannerMovies?[indexPath.row]
    return cell
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if let indexPath = collectionView.indexPathsForVisibleItems.first {
      pageControl.currentPage = indexPath.row
    }
  }
}
