//
//  DetailAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit

protocol DetailAssembler {
  func resolve() -> DetailViewController
  func resolve() -> DetailNavigator
}

extension DetailAssembler where Self: Assembler {
  func resolve() -> DetailViewController {
    return DetailViewController(navigator: resolve())
  }

  func resolve() -> DetailNavigator {
    return DefaultDetailNavigator(assembler: self)
  }
}
