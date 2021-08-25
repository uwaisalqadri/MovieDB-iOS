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
    imgBanner.pin
      .height(frame.height)
      .width(frame.width)

    imgBanner.sd_setImage(with: URL(string: "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.downgraf.com%2Fwp-content%2Fuploads%2F2015%2F06%2FClassic-Movie-Posters-5.jpg&f=1&nofb=1"), completed: nil)

    addSubview(imgBanner)
  }
}
