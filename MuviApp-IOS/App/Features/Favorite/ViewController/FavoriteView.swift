//
//  FavoriteView.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 26/08/21.
//

import UIKit

class FavoriteView: UIView {

  lazy var tblFavorite: UITableView = {
    return UITableView().apply { (tbl) in
      tbl.backgroundColor = .backgroundColor
      tbl.tableFooterView = UIView()
      tbl.allowsMultipleSelection = false
      tbl.showsVerticalScrollIndicator = false
      tbl.showsHorizontalScrollIndicator = false
      tbl.separatorEffect = .none
      tbl.register(cellType: FavoriteCell.self)
    }
  }()

  init() {
    super.init(frame: .zero)
    subviews(tblFavorite)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    configureViews()
  }

  private func configureViews() {

  }
}
