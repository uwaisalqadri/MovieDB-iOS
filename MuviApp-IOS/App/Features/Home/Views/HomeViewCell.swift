//
//  HomeViewCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import Reusable

class HomeViewCell: UITableViewCell, Reusable {

  lazy var lblMovie: UILabel = {
    let label = UILabel()
    label.tintColor = .black
    return label
  }()

  private func configureViews() {
    addSubview(lblMovie)
    lblMovie.pin.all()
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.width(size.width)
    configureViews()
    return CGSize(width: contentView.frame.width, height: lblMovie.frame.maxY + 10)
  }
}
