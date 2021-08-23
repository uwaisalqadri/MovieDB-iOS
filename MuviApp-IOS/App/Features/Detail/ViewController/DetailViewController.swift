//
//  DetailViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit

class DetailViewController: UIViewController {

  private let navigator: DetailNavigator

  init(navigator: DetailNavigator) {
    self.navigator = navigator
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

  }
}
