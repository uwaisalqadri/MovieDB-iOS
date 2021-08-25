//
//  PopularView.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 25/08/21.
//

import UIKit

class PopularView: UIView {
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical

    return UICollectionView(frame: .zero, collectionViewLayout: layout).apply { cl in
      cl.allowsMultipleSelection = false
      cl.showsVerticalScrollIndicator = false
      cl.showsHorizontalScrollIndicator = false
      cl.backgroundColor = .backgroundColor
      cl.register(cellType: PopularCell.self)
    }
  }()

  let refreshControl = UIRefreshControl()

  init() {
    super.init(frame: .zero)
    subviews(collectionView)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    configureViews()
  }

  private func configureViews() {
    collectionView.pin.all()
  }
}
