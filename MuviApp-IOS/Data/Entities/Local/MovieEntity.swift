//
//  MovieEntity.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 10/16/21.
//

import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class MovieEntity: Object, Movie, Mappable {
  dynamic var id: Int? = 0
  var adult: Bool?
  var backdropPath: String?
  var genreNames: [String]?
  var originalTitle: String?
  var overview: String?
  var popularity: Double?
  var posterPath: String?
  var releaseDate: String?
  var title: String?
  var video: Bool?
  var voteAverage: Double?
  var voteCount: Int?

  var genres: [Genre]?

  required convenience init?(map: Map) {
    self.init()
  }

  override class func primaryKey() -> String? {
    return "id"
  }

  func mapping(map: Map) {
    adult <- map["adult"]
    backdropPath <- map["backdrop_path"]
    genreNames <- map["genre_names"]
    id <- map["id"]
    originalTitle <- map["original_title"]
    overview <- map["overview"]
    popularity <- map["popularity"]
    posterPath <- map["poster_path"]
    releaseDate <- map["release_date"]
    title <- map["title"]
    video <- map["video"]
    voteAverage <- map["vote_average"]
    voteCount <- map["vote_count"]
  }

}
