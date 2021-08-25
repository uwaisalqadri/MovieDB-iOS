//
//  PopularCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 25/08/21.
//

import UIKit
import Reusable
import PinLayout

class PopularCell: UICollectionViewCell, Reusable {

  lazy var imgPoster: UIImageView = {
    return UIImageView().apply { img in
      img.contentMode = .scaleAspectFill
      img.backgroundColor = .yellow
    }
  }()

  lazy var lblGenre: UILabel = {
    return UILabel().apply { lbl in
      lbl.textColor = .black
      lbl.text = "Test"
    }
  }()

  lazy var lblTitle: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.textColor = .white
      lbl.text = "Oke"
    }
  }()

  lazy var lblDesc: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.textColor = .gray
      lbl.text = "Sip"
    }
  }()

  private func configureViews() {
    imgPoster.pin
      .width(160)
      .height(frame.height)
      .all()

    lblTitle.pin
      .below(of: imgPoster)
      .horizontally()
      .height(30)

    lblDesc.pin
      .below(of: lblTitle)
      .horizontally()
      .height(30)

    subviews {
      lblGenre
      lblDesc
      lblTitle
      imgPoster
    }
  }

  override func layoutSubviews() {
    configureViews()
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.height(size.height).width(size.width)
    configureViews()
    return CGSize(width: contentView.frame.width, height: 270)
  }

}
