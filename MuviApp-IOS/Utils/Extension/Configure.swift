//
//  Configure.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 03/06/21.
//

import Foundation

public func configure<T>(_ value: T, using closure: (inout T) throws -> Void) rethrows -> T {
  var value = value
  try closure(&value)
  return value
}
