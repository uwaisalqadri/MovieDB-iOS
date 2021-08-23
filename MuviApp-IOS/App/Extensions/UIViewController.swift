//
//  UIViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit
import SVProgressHUD

enum NavigationBarType {
  case logoAndIcon
  case searchBar
  case backTransparent
}

protocol NavigationBarButtonHandler {
  func leftNavigationBarButtonTapped(sender: UIBarButtonItem?)
  func rightNavigationBarButtonTapped(sender: UIBarButtonItem?)
}

extension UIViewController {

  private func setTransparentNavigationTheme() {
    navigationController?.navigationBar.backgroundColor = .clear
    navigationController?.navigationBar.barTintColor = .clear
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
  }

  func setNavigationBar(type: NavigationBarType) {
    switch type {
    case .logoAndIcon:
      navigationItem.rightBarButtonItem = createNotifButton()
      addLogo()
    case .searchBar:
      print("")
    case .backTransparent:
      navigationItem.leftBarButtonItem = createBackButton()
      setTransparentNavigationTheme()
    }
  }
}

extension UIViewController: NavigationBarButtonHandler {
  @objc func leftNavigationBarButtonTapped(sender: UIBarButtonItem?) {

  }

  @objc func rightNavigationBarButtonTapped(sender: UIBarButtonItem?) {

  }
}

extension UIViewController {
  private func createBackButton() -> UIBarButtonItem {
    let backButton = UIBarButtonItem(image: .iconBack, style: .plain, target: self, action: #selector(self.leftNavigationBarButtonTapped(sender:)))
    backButton.tintColor = .black
    backButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
    return backButton
  }

  private func createNotifButton() -> UIBarButtonItem {
    let notifButton = UIBarButtonItem(image: .iconNotif, style: .plain, target: self, action: #selector(self.leftNavigationBarButtonTapped(sender:)))
    notifButton.tintColor = .black
    notifButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
    return notifButton
  }

  private func addLogo() {
    let logo = UIImageView(frame: .init(x: 0, y: 0, width: 20, height: 19))
    logo.image = UIImage.logo?.withRenderingMode(.alwaysOriginal)
    logo.contentMode = .scaleAspectFit
    logo.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.leftNavigationBarButtonTapped(sender:))))

    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logo)
  }
}

extension UIViewController {

  var window : UIWindow {
    return UIApplication.shared.windows.first!
  }

  func addTapGestureToHideKeyboard() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }

  @objc public func hideKeyboard() {
    view.endEditing(true)
  }
}

extension UIViewController{
  func hideLoading(){
    SVProgressHUD.dismiss()
  }

  func showLoading(){
    SVProgressHUD.show()
  }
}
