//
//  PopularNavigator.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import UIKit

protocol PopularNavigator {

}

struct DefaultPopularNavigator: PopularNavigator {

  private let assembler: Assembler

  init(assembler: Assembler) {
    self.assembler = assembler
  }
}
