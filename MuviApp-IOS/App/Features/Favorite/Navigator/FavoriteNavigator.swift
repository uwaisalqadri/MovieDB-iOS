//
//  FavoriteNavigator.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit

protocol FavoriteNavigator {
  func navigateToDetail(from viewController: UIViewController, with id: Int)
}

struct DefaultFavoriteNavigator: FavoriteNavigator {

  private let assembler: Assembler

  init(assembler: Assembler) {
    self.assembler = assembler
  }

  func navigateToDetail(from viewController: UIViewController, with id: Int) {
    let navigator: DetailNavigator = assembler.resolve()
    navigator.navigateToDetail(from: viewController, with: id)
  }
}

