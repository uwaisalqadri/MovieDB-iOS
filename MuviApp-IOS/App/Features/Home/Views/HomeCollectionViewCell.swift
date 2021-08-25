//
//  HomeCollectionViewCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import Reusable

class HomeCollectionViewCell: UICollectionViewCell, Reusable {

  lazy var imgPoster: UIImageView = {
    return UIImageView().apply { img in
      img.contentMode = .scaleAspectFill
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

    addSubview(imgPoster)
  }
}
