//
//  Constants.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation


struct Constants {

  static let baseUrl = "https://api.themoviedb.org/3/"
  static let apiKey = "270363a57bb9637a16bdd04f9979e433"
  static let placeHolder = "https://www.btklsby.go.id/images/placeholder/basic.png"
  static let urlImage = "https://image.tmdb.org/t/p/original"
  static let lang = "en-US"
  static let sortBy = "popularity.desc"
  static let formatFromApi = "yyyy-MM-dd"
  static let dateFormat = "dd MMM, yyyy"
  static let typeMovie = "movie"
  static let youtubeUrl = "https://www.youtube.com/embed/"

}

enum Endpoint {
  case discover
  case genre
  case search
  case detail
  case credits
  case videos
}

func getEndpoint(
  endpoint: Endpoint,
  query: String = "",
  idMovie: Int = 0,
  apiKey: String = Constants.apiKey,
  lang: String = Constants.lang,
  sortBy: String = Constants.sortBy,
  adult: Bool = false,
  page: Int = 1,
  year: String = "2020"
) -> String {
  switch endpoint {
  case .discover:
    return "discover/movie?api_key=\(apiKey)&languange=\(lang)&sort_by=\(sortBy)&include_adult=\(adult)&page=\(page)&year=\(year)"
  case .genre:
    return "genre/movie/list"
  case .search:
    return "search/movie?api_key=\(apiKey)&languange=\(lang)&page=\(page)&query=\(query)"
  case .detail:
    return "movie/\(idMovie)?api_key=\(apiKey)&language=\(lang)"
  case .credits:
    return "movie/\(idMovie)credits?api_key=\(apiKey)&language=\(lang)"
  case .videos:
    return "movie/\(idMovie)videos?api_key=\(apiKey)&language=\(lang)"
  }
}
