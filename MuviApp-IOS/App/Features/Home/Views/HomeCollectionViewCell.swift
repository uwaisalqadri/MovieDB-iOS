//
//  HomeCollectionViewCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import Reusable
import SDWebImage

class HomeCollectionViewCell: UICollectionViewCell, Reusable {

  lazy var imgPoster: UIImageView = {
    return UIImageView().apply { img in
      img.contentMode = .scaleAspectFit
    }
  }()

  var movie: Movie? {
    didSet {
      setContent()
    }
  }

  func setContent() {
    imgPoster.sd_setImage(with: URL(string: Constants.imgUrl + (movie?.posterPath)!))
  }

  override func layoutSubviews() {
    configureViews()
  }

  private func configureViews() {
    imgPoster.backgroundColor = .orange

    subviews(imgPoster)

    imgPoster.pin
      .height(frame.height)
      .width(102)

  }
}
