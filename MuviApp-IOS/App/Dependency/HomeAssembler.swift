//
//  HomeAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit

protocol HomeAssembler {
  func resolve() -> HomeTabBarViewController
  func resolve() -> HomeNavigator
}

extension HomeAssembler where Self: Assembler {
  func resolve() -> HomeTabBarViewController {
    return HomeTabBarViewController()
  }

  func resolve() -> HomeNavigator {
    return DefaultHomeNavigator(assembler: self)
  }
}
