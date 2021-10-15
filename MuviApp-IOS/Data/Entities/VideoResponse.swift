//
//  VideoResponse.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 05/10/21.
//

import Foundation
import ObjectMapper

class VideoResponse: Videos, Mappable {
  var id: Int?
  var _results: [VideoItem]?
  var results: [Video]? {
    _results
  }

  required init?(map: Map) {
    mapping(map: map)
  }

  func mapping(map: Map) {
    id <- map["id"]
    _results <- map["results"]
  }


}

class VideoItem: Video, Mappable {
  var id: String?
  var key: String?
  var name: String?
  var site: String?
  var size: Int?
  var type: String?

  required init?(map: Map) {
    mapping(map: map)
  }

  func mapping(map: Map) {
    id <- map["id"]
    key <- map["key"]
    name <- map["name"]
    site <- map["site"]
    size <- map["size"]
    type <- map["type"]
  }


}
