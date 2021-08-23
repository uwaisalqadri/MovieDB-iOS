//
//  HomeView.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import PinLayout

class HomeView: UIView {

  lazy var scrollView: UIScrollView = {
    return UIScrollView()
  }()

  lazy var contentView: UIView = {
    return UIView()
  }()

  lazy var tableView: UITableView = {
    return UITableView().apply {
      $0.backgroundColor = .backgroundColor
      $0.tableFooterView = UIView()
      $0.register(cellType: HomeViewCell.self)
      $0.register(cellType: HomeSliderViewCell.self)
    }
  }()

  init() {
    super.init(frame: .zero)
    addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(tableView)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    configureViews()
  }

  private func configureViews() {

    scrollView.pin.all()
    contentView.pin.size(of: scrollView)
    tableView.pin.size(of: contentView)
  }
}
