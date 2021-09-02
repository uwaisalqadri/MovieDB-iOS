//
//  CastCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 28/08/21.
//

import UIKit
import Reusable
import PinLayout

class CastCell: UICollectionViewCell, Reusable {

  lazy var imgCast: UIImageView = {
    return UIImageView().apply { (img) in
      img.contentMode = .scaleAspectFill
    }
  }()

  lazy var lblCast: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.font = .systemFont(ofSize: 12)
    }
  }()

  private func configureViews() {

    imgCast.backgroundColor = .blue
    lblCast.text = "Dave Franco"

    contentView.pin.all()

    imgCast.pin
      .top()
      .horizontally()
      .size(.init(width: 90, height: 90))

    lblCast.pin
      .below(of: imgCast)
      .horizontally()
      .margin(20)

  }

  override func layoutSubviews() {
    configureViews()
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.size(size)
    configureViews()
    return CGSize(width: frame.width, height: frame.height)
  }
}
