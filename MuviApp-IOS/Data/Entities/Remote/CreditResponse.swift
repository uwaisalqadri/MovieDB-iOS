//
//  CreditResponse.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 05/10/21.
//

import Foundation
import ObjectMapper

class CreditResponse: Credits, Mappable {
  var id: Int?
  var _cast: [CreditItem]?
  var cast: [Credit]? {
    _cast
  }

  required init?(map: Map) {
    mapping(map: map)
  }

  func mapping(map: Map) {
    id <- map["id"]
    _cast <- map["cast"]
  }


}

class CreditItem: Credit, Mappable {
  var adult: Bool?
  var castId: Int?
  var character: String?
  var creditId: String?
  var gender: Int?
  var id: Int?
  var knownForDepartment: String?
  var name: String?
  var order: Int?
  var originalName: String?
  var popularity: Double?
  var profilePath: String?

  required init?(map: Map) {
    mapping(map: map)
  }

  func mapping(map: Map) {
    adult <- map["adult"]
    castId <- map["cast_id"]
    character <- map["character"]
    creditId <- map["credit_id"]
    gender <- map["gender"]
    id <- map["id"]
    knownForDepartment <- map["known_for_department"]
    name <- map["name"]
    order <- map["order"]
    originalName <- map["original_name"]
    popularity <- map["popularity"]
    profilePath <- map["profile_path"]
  }


}
