//
//  UIView.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 25/08/21.
//

import UIKit

extension UIView {

  @discardableResult
  func subviews(_ subViews: UIView...) -> UIView {
    subviews(subViews)
  }

  @discardableResult
  func subviews(@SubviewsBuilder content: () -> [UIView]) -> UIView {
    subviews(content())
  }

  @discardableResult
  func subviews(@SubviewsBuilder content: () -> UIView) -> UIView {
    let subview = content()
    subviews(subview)
    return self
  }

  @discardableResult
  @objc
  func subviews(_ subViews: [UIView]) -> UIView {
    for sv in subViews {
      addSubview(sv)
      sv.translatesAutoresizingMaskIntoConstraints = false
    }
    return self
  }
}

@_functionBuilder public struct SubviewsBuilder {
  public static func buildBlock(_ content: UIView...) -> [UIView] {
    return content
  }
}
