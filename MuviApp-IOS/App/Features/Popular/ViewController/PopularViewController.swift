//
//  PopularViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit

class PopularViewController: UIViewController {

  override func viewWillAppear(_ animated: Bool) {
    setNavigationBar(type: .searchBar)
  }

  override func rightNavigationBarButtonTapped(sender: UIBarButtonItem?) {
    print("Seach")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

  }
}
