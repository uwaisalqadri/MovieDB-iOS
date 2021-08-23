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

  private func configureViews() {
    addSubview(imgBanner)
    imgBanner.sd_setImage(with: URL(string: "https://miro.medium.com/max/1400/1*_ygwCINLIqSJdaxO71Sm6Q.png"), completed: nil)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.width(size.width).height(size.height)
    configureViews()
    return CGSize(width: contentView.frame.width, height: 230)
  }
}
