//
//  FavoriteNavigator.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit

protocol FavoriteNavigator {

}

struct DefaultFavoriteNavigator: FavoriteNavigator {

  private let assembler: Assembler

  init(assembler: Assembler) {
    self.assembler = assembler
  }
}
