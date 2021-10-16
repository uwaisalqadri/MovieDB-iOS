//
//  FavoriteCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 26/08/21.
//

import UIKit
import Reusable
import PinLayout
import SDWebImage

class FavoriteCell: UITableViewCell, Reusable {

  lazy var imgFavorite: UIImageView = {
    return UIImageView().apply { (img) in
      img.contentMode = .scaleAspectFill
      img.sd_imageIndicator = SDWebImageActivityIndicator.medium
    }
  }()

  private let content = UIView()

  lazy var lblTitle: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.numberOfLines = 1
      lbl.textColor = .white
      lbl.font = .systemFont(ofSize: 16)
    }
  }()

  lazy var lblYear: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.numberOfLines = 1
      lbl.textColor = .lightGray
      lbl.font = .systemFont(ofSize: 14)
    }
  }()

  lazy var lblGenre: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.numberOfLines = 2
      lbl.textColor = .gray
      lbl.font = .systemFont(ofSize: 12)
    }
  }()

  lazy var btnFavorite: UIButton = {
    return UIButton().apply { (btn) in
      btn.setImage(.iconHeart, for: .normal)
    }
  }()

  var movie: Movie? {
    didSet {
      configureViews()
    }
  }

  var removeHandler: ((Movie) -> Void)?

  private func configureViews() {

    imgFavorite.sd_setImage(with: URL(string: Constants.imgUrl + (movie?.backdropPath ?? "")))
    lblYear.text = movie?.releaseDate?.formatDate(withFormat: "yyyy")
    lblTitle.text = movie?.title
    lblGenre.text = movie?.genreNames?.joined(separator: ", ")

    btnFavorite.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)

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
      .right(to: btnFavorite.edge.left)
      .left(to: imgFavorite.edge.right)
      .margin(8)

    lblTitle.pin
      .horizontally()
      .height(20)

    lblYear.pin
      .below(of: lblTitle)
      .bottom()
      .horizontally()
      .height(20)

    lblGenre.pin
      .horizontally()
      .below(of: lblYear)
      .bottom()

  }

  @objc func didTapButton(_ sender: Any) {
    guard let movie = movie else { return }
    removeHandler?(movie)
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
