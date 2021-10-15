//
//  SearchCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 25/08/21.
//

import UIKit
import Reusable
import PinLayout
import SDWebImage

class SearchCell: UICollectionViewCell, Reusable {

  lazy var imgPoster: UIImageView = {
    return UIImageView().apply { img in
      img.contentMode = .scaleToFill
      img.sd_imageIndicator = SDWebImageActivityIndicator.medium
      img.layer.masksToBounds = false
      img.clipsToBounds = true
    }
  }()

  lazy var lblGenre: UILabel = {
    return PaddedLabel().apply { lbl in
      lbl.textColor = .black
      lbl.numberOfLines = 1
      lbl.insets = .init(top: 10, left: 10, bottom: 10, right: 10)
      lbl.font = .boldSystemFont(ofSize: 12)
      lbl.backgroundColor = .accentColor
      lbl.layer.cornerRadius = 5
    }
  }()

  lazy var lblTitle: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.textColor = .white
      lbl.numberOfLines = 1
      lbl.font = .systemFont(ofSize: 15)
    }
  }()

  lazy var lblDesc: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.textColor = .gray
      lbl.numberOfLines = 2
      lbl.font = .systemFont(ofSize: 12)
    }
  }()

  var movie: Movie? {
    didSet {
      configureViews()
    }
  }

  private func configureViews() {

    imgPoster.layer.cornerRadius = 5
    imgPoster.sd_setImage(with: URL(string: Constants.imgUrl + (movie?.posterPath ?? "")), completed: nil)

    lblTitle.text = movie?.title
    lblDesc.text = movie?.overview
    lblGenre.text = movie?.releaseDate?.formatDate(withFormat: "dd MMM, yyyy")

    subviews {
      imgPoster
      lblDesc
      lblTitle
      lblGenre
    }

    imgPoster.pin
      .width(frame.width)
      .height(214)
      .horizontally()
      .top()
      .bottom(20)

    lblGenre.pin
      .bottom(to: imgPoster.edge.bottom)
      .left(to: imgPoster.edge.left)
      .width(100)
      .height(16)
      .margin(7)

    lblTitle.pin
      .below(of: imgPoster)
      .horizontally()
      .bottom()
      .height(16)

    lblDesc.pin
      .below(of: lblTitle)
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
