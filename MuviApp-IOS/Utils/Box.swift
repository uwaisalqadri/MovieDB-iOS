//
//  Box.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 08/05/21.
//

import Foundation

class Box<T> {
  typealias Listener = (T) -> Void
  var listener: Listener?

  var value: T {
    didSet {
      listener?(value)
    }
  }

  init(_ value: T) {
    self.value = value
  }

  func observe(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
