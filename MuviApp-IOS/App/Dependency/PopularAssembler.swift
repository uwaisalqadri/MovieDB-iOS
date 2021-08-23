//
//  PopularAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit

protocol PopularAssembler {
  func resolve() -> PopularViewController
  func resolve() -> PopularNavigator
}

extension PopularAssembler where Self: Assembler {
  func resolve() -> PopularNavigator {
    return DefaultPopularNavigator(assembler: self)
  }

  func resolve() -> PopularViewController {
    return PopularViewController()
  }
}
