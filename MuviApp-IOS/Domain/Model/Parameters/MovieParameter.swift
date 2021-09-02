//
//  MovieParameter.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation

struct DiscoverParamater: Encodable {
  let api_key: String
  let language: String
  let sort_by: SortType
  let page: Int
  let year: String

  enum SortType: String, Encodable {
    case popularity = "popularity.desc"
    case releaseDate = "release_date.desc"
    case voteAverage = "vote_average.desc"
  }

  init(apiKey: String, language: String, sortBy: SortType, page: Int = 1, year: String) {
    self.api_key = apiKey
    self.language = language
    self.sort_by = sortBy
    self.page = page
    self.year = year
  }
}

struct DetailParameter: Encodable {
  let api_key: String
  let language: String
  let movie_id: Int

  init(apiKey: String, language: String, movieId: Int) {
    self.api_key = apiKey
    self.language = language
    self.movie_id = movieId
  }
}
