//
//  PopularAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit

protocol PopularAssembler {
  func resolve() -> SearchViewController
  func resolve() -> SearchNavigator
}

extension PopularAssembler where Self: Assembler {
  func resolve() -> SearchNavigator {
    return DefaultPopularNavigator(assembler: self)
  }

  func resolve() -> SearchViewController {
    return SearchViewController()
  }
}
