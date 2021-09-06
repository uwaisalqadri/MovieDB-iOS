//
//  SearchView.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 25/08/21.
//

import UIKit

class SearchView: UIView {

  lazy var lblDesc: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.font = .systemFont(ofSize: 16)
      lbl.textColor = .white
    }
  }()

  lazy var lblSearched: UILabel = {
    return UILabel().apply { (lbl) in
      lbl.font = .boldSystemFont(ofSize: 16)
      lbl.textColor = .white
    }
  }()

  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical

    return UICollectionView(frame: .zero, collectionViewLayout: layout).apply { cl in
      cl.allowsMultipleSelection = false
      cl.showsVerticalScrollIndicator = false
      cl.showsHorizontalScrollIndicator = false
      cl.backgroundColor = .backgroundColor
      cl.register(cellType: SearchCell.self)
    }
  }()

  lazy var txtSearch: UITextField = {
    return UITextField(frame: .init(x: 0, y: 0, width: 300, height: 50)).apply { (searchBar) in
      searchBar.textColor = .white
      searchBar.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray as Any])
      searchBar.tintColor = .accentColor
      searchBar.autocorrectionType = .no
      searchBar.autocapitalizationType = .none
    }
  }()

  let refreshControl = UIRefreshControl()

  init() {
    super.init(frame: .zero)
    subviews {
      lblDesc
      lblSearched
      collectionView
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    configureViews()
  }

  private func configureViews() {
    lblSearched.text = "'Maze Runner'"
    lblDesc.text = "Showing Result of"

    lblSearched.pin
      .height(16)
      .right()
      .marginLeft(25)
      .marginTop(20)
      .right(of: lblDesc)
      .vertically()

    lblDesc.pin
      .height(16)
      .all()
      .marginLeft(20)
      .marginTop(20)

    collectionView.pin
      .below(of: lblDesc)
      .all()
      .margin(20)
  }
}
