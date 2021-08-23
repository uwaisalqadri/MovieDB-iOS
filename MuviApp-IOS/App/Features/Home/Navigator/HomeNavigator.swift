//
//  HomeNavigator.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit

protocol HomeNavigator {
  func navigateToHome(window: UIWindow?)

  var homeViewController: HomeViewController { get }
  var popularViewController: PopularViewController { get }
  var favoriteViewController: FavoriteViewController { get }
}

struct DefaultHomeNavigator: HomeNavigator {

  private let assembler: Assembler

  init(assembler: Assembler) {
    self.assembler = assembler
  }

  func navigateToHome(window: UIWindow?) {
    let homeTabBar: HomeTabBarViewController = assembler.resolve()
    window?.rootViewController = homeTabBar
  }

  var homeViewController: HomeViewController {
    assembler.resolve()
  }

  var popularViewController: PopularViewController {
    assembler.resolve()
  }

  var favoriteViewController: FavoriteViewController {
    assembler.resolve()
  }
}
