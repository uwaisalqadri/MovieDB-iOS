//
//  View+Ext.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 03/06/21.
//

import UIKit

extension UIView {

  public var width: CGFloat {
    return self.frame.size.width
  }

  public var height: CGFloat {
    return self.frame.size.height
  }

  public var top: CGFloat {
    return self.frame.origin.y
  }

  public var bottom: CGFloat {
    return self.frame.size.height + self.frame.origin.y
  }

  public var left: CGFloat {
    return self.frame.origin.x
  }

  public var right: CGFloat {
    return self.frame.size.width + self.frame.origin.x
  }

  func fillSuperView() {
    anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
  }

  func anchorSize(to view: UIView) {
    widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
  }

  func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {

    translatesAutoresizingMaskIntoConstraints = false

    if let top = top {
      topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
    }

    if let leading = leading {
      leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
    }

    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
    }

    if let trailing = trailing {
      trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
    }

    if size.width != 0 {
      widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }

    if size.height != 0 {
      heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
  }
}
