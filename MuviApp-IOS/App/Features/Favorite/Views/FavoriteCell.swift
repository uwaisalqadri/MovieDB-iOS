//
//  FavoriteCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 26/08/21.
//

import UIKit
import Reusable
import PinLayout

class FavoriteCell: UITableViewCell, Reusable {

  lazy var imgFavorite: UIImageView = {
    return UIImageView().apply { (img) in
      img.contentMode = .scaleToFill
    }
  }()

  lazy var lblTitle: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.numberOfLines = 1
    }
  }()

  lazy var lblYear: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.numberOfLines = 1
    }
  }()

  lazy var lblGenre: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.numberOfLines = 1
    }
  }()

  lazy var btnFavorite: UIButton = {
    return UIButton().apply { (btn) in

    }
  }()

  override func layoutSubviews() {
    configureViews()
  }

  private func configureViews() {
    contentView.pin.all()

    subviews {
      imgFavorite
      lblTitle
      lblYear
      lblGenre
      btnFavorite
    }
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.width(size.width).height(size.height)
    return CGSize(width: frame.width, height: frame.height)
  }
}
