//
//  FavoriteAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit

protocol FavoriteAssembler {
  func resolve() -> FavoriteNavigator
  func resolve() -> FavoriteViewController
}

extension FavoriteAssembler where Self: Assembler {

  func resolve() -> FavoriteNavigator {
    return DefaultFavoriteNavigator(assembler: self)
  }

  func resolve() -> FavoriteViewController {
    return FavoriteViewController()
  }
}
