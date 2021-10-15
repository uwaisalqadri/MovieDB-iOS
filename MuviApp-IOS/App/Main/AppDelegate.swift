//
//  AppDelegate.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  private let assembler = AppAssembler()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)

//    let navigator: HomeNavigator = assembler.resolve()
//    navigator.navigateToHome(window: window)
    window?.rootViewController = DetailViewController(navigator: assembler.resolve(), viewModel: assembler.resolve(with: 703771))
    window?.makeKeyAndVisible()

    return true
  }
}

