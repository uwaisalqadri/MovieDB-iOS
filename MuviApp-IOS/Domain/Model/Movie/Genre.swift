//
//  Genre.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 05/10/21.
//

import Foundation

protocol Genres {
  var genres: [Genre]? { get }
}

protocol Genre {
  var id: Int? { get }
  var name: String? { get }
}
