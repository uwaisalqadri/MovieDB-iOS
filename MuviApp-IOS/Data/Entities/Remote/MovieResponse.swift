//
//  MovieResponse.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation
import ObjectMapper

class MovieResponse: Movies, Mappable {
  var page: Int?
  var results: [Movie]? {
    _results
  }
  var _results: [MovieItem]?
  var totalPages: Int?
  var totalResults: Int?

  required init?(map: Map) {
    mapping(map: map)
  }

  func mapping(map: Map) {
    page <- map["page"]
    _results <- map["results"]
    totalPages <- map["total_pages"]
    totalResults <- map["total_results"]
  }
}

class MovieItem: Movie, Mappable {
  var adult: Bool?
  var backdropPath: String?
  var genreIds: [Int]?
  var id: Int?
  var originalTitle: String?
  var overview: String?
  var popularity: Double?
  var posterPath: String?
  var releaseDate: String?
  var title: String?
  var video: Bool?
  var voteAverage: Double?
  var voteCount: Int?

  var _genres: [GenreItem]?
  var genres: [Genre]? {
    _genres
  }

  required init?(map: Map) {
    mapping(map: map)
  }

  func mapping(map: Map) {
    adult <- map["adult"]
    backdropPath <- map["backdrop_path"]
    genreIds <- map["genre_ids"]
    _genres <- map["genres"]
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
