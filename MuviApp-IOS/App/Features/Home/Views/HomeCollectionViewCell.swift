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

  override func layoutSubviews() {
    configureViews()
  }

  private func configureViews() {
    imgPoster.backgroundColor = .orange

    imgPoster.pin
      .height(frame.height)
      .width(102)

    subviews(imgPoster)
  }
}
