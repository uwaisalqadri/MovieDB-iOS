//
//  DetailNavigator.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit

protocol DetailNavigator {
  func navigateToDetail(from viewController: UIViewController)
}

struct DefaultDetailNavigator: DetailNavigator {

  private let assembler: Assembler

  init(assembler: Assembler) {
    self.assembler = assembler
  }

  func navigateToDetail(from viewController: UIViewController) {
    let nextViewController = DetailViewController(navigator: assembler.resolve())
    nextViewController.hidesBottomBarWhenPushed = true
    viewController.navigationController?.pushViewController(nextViewController, animated: true)
  }
}
