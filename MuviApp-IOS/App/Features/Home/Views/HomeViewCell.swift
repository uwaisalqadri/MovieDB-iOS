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

  override func awakeFromNib() {
    super.awakeFromNib()
    configureViews()
  }

  private func configureViews() {
    addSubview(lblMovie)
  }
}
