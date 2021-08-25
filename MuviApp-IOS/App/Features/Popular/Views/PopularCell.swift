//
//  PopularCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 25/08/21.
//

import UIKit
import Reusable
import PinLayout

class PopularCell: UITableViewCell, Reusable {

  lazy var imgPoster: UIImageView = {
    return UIImageView().apply { img in
      img.contentMode = .scaleAspectFill
    }
  }()

  lazy var lblGenre: UILabel = {
    return UILabel().apply { lbl in
      lbl.textColor = .black
    }
  }()

  lazy var lblTitle: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.textColor = .white
    }
  }()

  lazy var lblDesc: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.textColor = .gray
    }
  }()

  override func layoutSubviews() {
    configureViews()
  }

  private func configureViews() {
    
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.height(size.height).width(size.width)
    configureViews()
    return CGSize(width: contentView.frame.width, height: 500)
  }

}
