//
//  SearchNavigator.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit

protocol SearchNavigator {
  func navigateToDetail(from viewController: UIViewController, with id: Int)
}

struct DefaultPopularNavigator: SearchNavigator {

  private let assembler: Assembler

  init(assembler: Assembler) {
    self.assembler = assembler
  }

  func navigateToDetail(from viewController: UIViewController, with id: Int) {
    let navigator: DetailNavigator = assembler.resolve()
    navigator.navigateToDetail(from: viewController, with: id)
  }
}
