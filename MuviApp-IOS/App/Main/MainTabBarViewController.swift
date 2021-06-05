//
//  MainTabBarViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 05/06/21.
//

import UIKit

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    configureTabBar()
  }

  private func configureTabBar() {
    delegate = self
    tabBar.isTranslucent = false
    tabBar.barTintColor = UIColor(named: "AccentColor")
    tabBar.tintColor = .black

//    let homeTab = createTabController(viewController: T##UIViewController, title: "Home", active: getImage(image: .home), inactive: getImage(image: .home))
//
//    let popularTab = createTabController(viewController: T##UIViewController, title: "Popular", active: getImage(image: .popular), inactive: getImage(image: .popular))
//
//    let favoriteTab = createTabController(viewController: UIViewController, title: "Favorite", active: getImage(image: .favorite), inactive: getImage(image: .favorite))
//
//    viewControllers = [homeTab, popularTab, favoriteTab]
  }

  private func createTabController(viewController: UIViewController, title: String, active: UIImage, inactive: UIImage) -> UINavigationController {
    let tabController = UINavigationController(rootViewController: viewController)
    tabController.tabBarItem.image = inactive.withRenderingMode(.alwaysTemplate)
    tabController.tabBarItem.selectedImage = active.withRenderingMode(.alwaysTemplate)
    tabController.tabBarItem.title = title
    tabController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -4.0)
    return tabController
  }

  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

  }
}

//enum TabImage {
//  case home
//  case popular
//  case favorite
//
//  private func getImage(image: TabImage) -> UIImage {
//    let image = UIImage(systemName: "home")
//    switch image {
//    case .home:
//      return UIImage(named: "HomeIcon")
//    case .popular:
//      return UIImage(named: "PopularIcon")
//    case .favorite:
//      return UIImage(named: "FavoriteIcon")
//    }
//  }
//}
