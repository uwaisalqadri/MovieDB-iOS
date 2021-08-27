//
//  HomeViewCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import Reusable
import PureLayout

class HomeViewCell: UITableViewCell, Reusable {

  lazy var lblCategory: UILabel = {
    return UILabel().apply { lbl in
      lbl.textColor = .white
      lbl.font = .boldSystemFont(ofSize: 18)
    }
  }()

  lazy var clCategory: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal

    return UICollectionView(frame: .zero, collectionViewLayout: layout).apply { cl in
      cl.allowsMultipleSelection = false
      cl.showsVerticalScrollIndicator = false
      cl.showsHorizontalScrollIndicator = false
      cl.backgroundColor = .backgroundColor
      cl.delegate = self
      cl.dataSource = self
      cl.register(cellType: HomeCollectionViewCell.self)
    }
  }()

  override func layoutSubviews() {
    configureViews()
  }

  private func configureViews() {

    subviews {
      lblCategory
      clCategory
    }

    lblCategory.pin
      .top(20)
      .bottom(20)
      .left(10)
      .height(50)
      .width(contentView.frame.width)

//    lblCategory.autoPinEdge(.top, to: .top, of: contentView, withOffset: 20)
//    lblCategory.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 10)
//    lblCategory.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: 10)
//    lblCategory.autoSetDimensions(to: .init(width: frame.width, height: 50))

    clCategory.pin
      .below(of: lblCategory)
      .horizontally(10)
      .bottom()
      .top(20)

//    clCategory.autoPinEdge(.top, to: .bottom, of: lblCategory)
//    clCategory.autoPinEdge(.bottom, to: .bottom, of: contentView)
//    clCategory.autoPinEdge(.leading, to: .leading, of: contentView)
//    clCategory.autoPinEdge(.trailing, to: .trailing, of: contentView)
//    clCategory.autoSetDimension(.width, toSize: frame.width - 20)
//    clCategory.autoPinEdgesToSuperviewEdges(with: .init(top: 20, left: 10, bottom: 0, right: 10))
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin
      .width(size.width)

    configureViews()
    return CGSize(width: contentView.frame.width - 10, height: 220)
  }
}

extension HomeViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width/3.8, height: collectionView.frame.width/2)
  }
}

extension HomeViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: HomeCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    return cell
  }
}
