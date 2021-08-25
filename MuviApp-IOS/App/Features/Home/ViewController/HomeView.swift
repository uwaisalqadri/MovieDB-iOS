//
//  HomeView.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import PinLayout

class HomeView: UIView {

  lazy var tableView: UITableView = {
    return UITableView().apply {
      $0.backgroundColor = .backgroundColor
      $0.tableFooterView = UIView()
      $0.separatorEffect = .none
      $0.register(cellType: HomeViewCell.self)
      $0.register(cellType: HomeBannerViewCell.self)
    }
  }()

  let refreshControl = UIRefreshControl()

  init() {
    super.init(frame: .zero)
    subviews(tableView)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    configureViews()
  }

  private func configureViews() {

    tableView.pin.all()
  }
}
