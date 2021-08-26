//
//  SearchNavigator.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit

protocol SearchNavigator {
}

struct DefaultPopularNavigator: SearchNavigator {

  private let assembler: Assembler

  init(assembler: Assembler) {
    self.assembler = assembler
  }
}
