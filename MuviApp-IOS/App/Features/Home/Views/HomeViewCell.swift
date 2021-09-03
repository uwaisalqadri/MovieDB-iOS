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
      cl.showsHorizontalScrollIndicator = false
      cl.backgroundColor = .backgroundColor
      cl.delegate = self
      cl.dataSource = self
      cl.register(cellType: HomeCollectionViewCell.self)
    }
  }()

  var movieClickHandler: ((Movie) -> Void)?
  var movies: [Movie]? {
    didSet {
      clCategory.reloadData()
    }
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

    clCategory.pin
      .below(of: lblCategory)
      .horizontally(10)
      .bottom()
  }

  override func layoutSubviews() {
    configureViews()
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    contentView.pin.width(size.width).height(size.height)
    configureViews()
    return CGSize(width: contentView.frame.width - 10, height: 220)
  }
}



extension HomeViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width/3.8, height: collectionView.frame.width/2)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    movieClickHandler?(movies?[indexPath.row] as! Movie)
  }
}

extension HomeViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: HomeCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.movie = movies?[indexPath.row]
    return cell
  }
}
