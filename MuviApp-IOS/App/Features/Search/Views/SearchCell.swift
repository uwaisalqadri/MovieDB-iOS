//
//  SearchCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 25/08/21.
//

import UIKit
import Reusable
import PinLayout

class SearchCell: UICollectionViewCell, Reusable {

  lazy var imgPoster: UIImageView = {
    return UIImageView().apply { img in
      img.contentMode = .scaleToFill
      img.backgroundColor = .yellow
    }
  }()

  lazy var lblGenre: UILabel = {
    return PaddedLabel().apply { lbl in
      lbl.textColor = .black
      lbl.numberOfLines = 1
      lbl.insets = .init(top: 10, left: 10, bottom: 10, right: 10)
      lbl.font = .boldSystemFont(ofSize: 10)
      lbl.backgroundColor = .accentColor
      lbl.layer.cornerRadius = 5
    }
  }()

  lazy var lblTitle: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.textColor = .white
      lbl.numberOfLines = 1
      lbl.font = .systemFont(ofSize: 12)
    }
  }()

  lazy var lblDesc: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.textColor = .gray
      lbl.numberOfLines = 2
      lbl.font = .systemFont(ofSize: 10)
    }
  }()

  private func configureViews() {

    imgPoster.sd_setImage(with: URL(string: "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.downgraf.com%2Fwp-content%2Fuploads%2F2015%2F06%2FClassic-Movie-Posters-5.jpg&f=1&nofb=1"), completed: nil)

    lblTitle.text = "Maze Runner - Guide to Hell or something"
    lblDesc.text = "Dylan O'Brien, Kaya Scodelario, Will Poulter "
    lblGenre.text = "Action, Adventure, Drama, Gore, Slice of Life"

    subviews {
      imgPoster
      lblDesc
      lblTitle
      lblGenre
    }

    imgPoster.pin
      .width(frame.width)
      .height(214)
      .all()

    lblGenre.pin
      .bottom(to: imgPoster.edge.bottom)
      .horizontally()
      .height(16)
      .margin(7)

    lblTitle.pin
      .below(of: imgPoster)
      .horizontally()
      .top(10)
      .bottom()
      .height(14)

    lblDesc.pin
      .below(of: lblTitle)
      .horizontally()
      .top()
      .bottom()
      .height(12)
  }

  override func layoutSubviews() {
    configureViews()
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.height(size.height).width(size.width)
    configureViews()
    return CGSize(width: contentView.frame.width, height: contentView.frame.height)
  }

}
