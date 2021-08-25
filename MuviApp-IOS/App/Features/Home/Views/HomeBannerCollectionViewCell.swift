//
//  HomeBannerCollectionViewCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import Reusable
import SDWebImage

class HomeBannerCollectionViewCell: UICollectionViewCell, Reusable {

  lazy var imgBanner: UIImageView = {
    return UIImageView().apply {
      $0.contentMode = .scaleAspectFill
      $0.clipsToBounds = true
    }
  }()

  override func layoutSubviews() {
    configureViews()
  }

  private func configureViews() {
    contentView.backgroundColor = .blue
    imgBanner.pin.all(10)
    imgBanner.sd_setImage(with: URL(string: "https://miro.medium.com/max/1400/1*_ygwCINLIqSJdaxO71Sm6Q.png"), completed: nil)

    addSubview(imgBanner)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.width(size.width).height(size.height)
    return CGSize(width: contentView.frame.width, height: imgBanner.frame.height - 20)
  }
}
