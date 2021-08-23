//
//  DetailNavigator.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit

protocol DetailNavigator {
}

struct DefaultDetailNavigator: DetailNavigator {

  private let assembler: Assembler

  init(assembler: Assembler) {
    self.assembler = assembler
  }
}
