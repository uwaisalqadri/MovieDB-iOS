//
//  Video.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 05/10/21.
//

import Foundation

protocol Videos {
  var id: Int? { get }
  var results: [Video]? { get }
}

protocol Video {
  var id: String? { get }
  var key: String? { get }
  var name: String? { get }
  var site: String? { get }
  var size: Int? { get }
  var type: String? { get }
}
