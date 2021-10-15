//
//  GenreResponse.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 05/10/21.
//

import Foundation
import ObjectMapper

class GenreResponse: Genres, Mappable {

  var _genres: [GenreItem]?
  var genres: [Genre]? {
    _genres
  }

  required init?(map: Map) {
    mapping(map: map)
  }

  func mapping(map: Map) {
    _genres <- map["genres"]
  }


}

class GenreItem: Genre, Mappable {
  var id: Int?
  var name: String?

  required init?(map: Map) {
    mapping(map: map)
  }

  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
  }


}
