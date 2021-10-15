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

  private let content = UIView()

  lazy var lblTitle: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.numberOfLines = 1
      lbl.textColor = .white
    }
  }()

  lazy var lblYear: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.numberOfLines = 1
      lbl.textColor = .lightGray
    }
  }()

  lazy var lblGenre: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.numberOfLines = 1
      lbl.textColor = .gray
    }
  }()

  lazy var btnFavorite: UIButton = {
    return UIButton().apply { (btn) in
      btn.setImage(.iconHeart, for: .normal)
    }
  }()


  private func configureViews() {

    imgFavorite.backgroundColor = .blue
    lblYear.text = "2020"
    lblTitle.text = "Kim jong un"
    lblGenre.text = "nwodnw0djq09whowhhw"

    subviews {
      content
      imgFavorite
      btnFavorite
    }

    content.subviews {
      lblTitle
      lblYear
      lblGenre
    }

    contentView.pin.all()

    btnFavorite.pin
      .height(24)
      .width(24)
      .right()
      .top()
      .margin(14)

    imgFavorite.pin
      .vertically()
      .left()
      .width(160)
      .margin(14)

    content.pin
      .vertically()
      .right(of: imgFavorite)
      .horizontally()
      .margin(14)

    lblTitle.pin
      .horizontally()
      .height(20)

    lblYear.pin
      .below(of: lblTitle)
      .horizontally()
      .height(20)

    lblGenre.pin
      .below(of: lblYear)
      .horizontally()
      .height(20)

  }

  override func layoutSubviews() {
    configureViews()
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.width(size.width).height(size.height)
    configureViews()
    return CGSize(width: frame.width, height: 100)
  }
}
