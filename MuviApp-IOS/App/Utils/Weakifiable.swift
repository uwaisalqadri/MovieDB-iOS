//
//  Weakifiable.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import Foundation

protocol Weakifiable: class {}

extension NSObject: Weakifiable {}

extension Weakifiable {

  func weakify<T>(_ code: @escaping (Self, T) -> Void) -> (T) -> Void {
    return { [weak self] (data) in
      guard let self = self else { return }
      code(self, data)
    }
  }
}
