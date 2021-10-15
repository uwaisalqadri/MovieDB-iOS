//
//  CastCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 28/08/21.
//

import UIKit
import Reusable
import PinLayout
import SDWebImage

class CastCell: UICollectionViewCell, Reusable {

  lazy var imgCast: UIImageView = {
    return UIImageView().apply { (img) in
      img.contentMode = .scaleAspectFill
      img.layer.masksToBounds = false
      img.clipsToBounds = true
    }
  }()

  lazy var lblCast: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.font = .systemFont(ofSize: 12)
      lbl.textColor = .white
      lbl.numberOfLines = 2
      lbl.textAlignment = .center
    }
  }()

  var credit: Credit? {
    didSet {
      configureViews()
    }
  }

  private func configureViews() {

    subviews {
      imgCast
      lblCast
    }

    imgCast.circle()
    imgCast.sd_setImage(with: URL(string: Constants.imgUrl + (credit?.profilePath ?? "")))
    lblCast.text = credit?.name

    contentView.pin.all()

    imgCast.pin
      .top()
      .horizontally()
      .size(.init(width: 95, height: 95))

    lblCast.pin
      .below(of: imgCast)
      .horizontally()
      .bottom()
  }

  override func layoutSubviews() {
    configureViews()
  }
}

