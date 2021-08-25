//
//  HomeViewCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import Reusable

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
    lblCategory.pin
      .top(20)
      .bottom(5)
      .left(10)
      .height(20)
      .width(contentView.frame.width)

    clCategory.pin
      .below(of: lblCategory)
      .all()

    [lblCategory, clCategory].forEach {
      addSubview($0)
    }
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.width(size.width)
    configureViews()
    return CGSize(width: contentView.frame.width, height: 200)
  }
}

extension HomeViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.width/2)
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
