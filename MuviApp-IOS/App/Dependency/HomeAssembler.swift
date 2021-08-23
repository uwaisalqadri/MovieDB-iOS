//
//  HomeAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit

protocol HomeAssembler {
  func resolve() -> HomeNavigator
  func resolve() -> HomeTabBarViewController
  func resolve() -> HomeViewController
}

extension HomeAssembler where Self: Assembler {
  func resolve() -> HomeTabBarViewController {
    return HomeTabBarViewController(navigator: resolve())
  }

  func resolve() -> HomeViewController {
    return HomeViewController()
  }

  func resolve() -> HomeNavigator {
    return DefaultHomeNavigator(assembler: self)
  }
}
