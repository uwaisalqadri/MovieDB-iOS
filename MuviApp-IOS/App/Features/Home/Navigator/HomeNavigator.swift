//
//  HomeNavigator.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit

protocol HomeNavigator {
  func navigateToHome(window: UIWindow?)
  func navigateToDetail(from viewController: UIViewController)

  var homeViewController: HomeViewController { get }
  var popularViewController: SearchViewController { get }
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

  func navigateToDetail(from viewController: UIViewController) {
    let navigator: DetailNavigator = assembler.resolve()
    navigator.navigateToDetail(from: viewController)
  }

  var homeViewController: HomeViewController {
    assembler.resolve()
  }

  var popularViewController: SearchViewController {
    assembler.resolve()
  }

  var favoriteViewController: FavoriteViewController {
    assembler.resolve()
  }
}
