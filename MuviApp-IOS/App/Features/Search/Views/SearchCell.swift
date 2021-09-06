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

  var movie: Movie? {
    didSet {
      configureViews()
    }
  }

  private func configureViews() {

    imgPoster.sd_setImage(with: URL(string: Constants.imgUrl + (movie?.posterPath ?? "")), completed: nil)

    lblTitle.text = movie?.title
    lblDesc.text = movie?.overview
    lblGenre.text = movie?.releaseDate

    subviews {
      imgPoster
      lblDesc
      lblTitle
      lblGenre
    }

    imgPoster.pin
      .width(frame.width)
      .height(214)
      .marginHorizontal(15)
      .horizontally()
      .top()
      .bottom(20)

    lblGenre.pin
      .bottom(to: imgPoster.edge.bottom)
      .right(to: imgPoster.edge.right)
      .left(to: imgPoster.edge.left)
      .height(16)
      .margin(7)

    lblTitle.pin
      .below(of: imgPoster)
      .marginHorizontal(15)
      .horizontally()
      .bottom()
      .height(16)

    lblDesc.pin
      .below(of: lblTitle)
      .marginHorizontal(15)
      .horizontally()
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
