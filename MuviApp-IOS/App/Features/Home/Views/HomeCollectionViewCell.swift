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
    imgPoster.sd_setImage(with: URL(string: "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.downgraf.com%2Fwp-content%2Fuploads%2F2015%2F06%2FClassic-Movie-Posters-5.jpg&f=1&nofb=1"), completed: nil)

    imgPoster.pin
      .height(frame.height)
      .width(102)

    subviews(imgPoster)
  }
}
