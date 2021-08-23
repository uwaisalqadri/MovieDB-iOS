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
      $0.showsVerticalScrollIndicator = false
      $0.isPagingEnabled = true
      $0.register(cellType: HomeBannerCollectionViewCell.self)
    }
  }()

  let pageControl = UIPageControl()

  private func configureViews() {
    [collectionView, pageControl].forEach {
      contentView.addSubview($0)
    }
    contentView.backgroundColor = .backgroundColor
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.width(size.width)
    configureViews()
    return CGSize(width: frame.width, height: 230)
  }
}

extension HomeBannerViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: frame.width, height: collectionView.frame.size.width)
  }
}

extension HomeBannerViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: HomeBannerCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    return cell
  }
}
