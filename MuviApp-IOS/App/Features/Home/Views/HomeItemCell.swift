//
//  HomeItemCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import Reusable
import SDWebImage

class HomeItemCell: UICollectionViewCell, Reusable {

  lazy var imgPoster: UIImageView = {
    return UIImageView().apply { img in
      img.contentMode = .scaleAspectFit
      img.sd_imageIndicator = SDWebImageActivityIndicator.medium
    }
  }()

  var movie: Movie? {
    didSet {
      configureViews()
    }
  }

  func configureViews() {
    imgPoster.sd_setImage(with: URL(string: Constants.imgUrl + (movie?.posterPath ?? "")))

    subviews(imgPoster)

    imgPoster.pin
      .height(frame.height)
      .width(102)
  }

}
