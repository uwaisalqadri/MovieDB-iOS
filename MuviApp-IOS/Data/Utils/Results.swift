//
//  Results.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 10/16/21.
//

import RealmSwift

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
