//
//  HomeBannerItemCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import Reusable
import SDWebImage

class HomeBannerItemCell: UICollectionViewCell, Reusable {

  lazy var imgBanner: UIImageView = {
    return UIImageView().apply {
      $0.contentMode = .scaleAspectFill
      $0.clipsToBounds = true
      $0.sd_imageIndicator = SDWebImageActivityIndicator.medium
    }
  }()

  var movie: Movie? {
    didSet {
      configureViews()
    }
  }

  private func configureViews() {

    imgBanner.sd_setImage(with: URL(string: Constants.imgUrl + (movie?.backdropPath ?? "")))

    imgBanner.pin
      .height(frame.height)
      .width(frame.width)

    subviews(imgBanner)
  }

}
