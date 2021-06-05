//
//  Endpoint.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 03/06/21.
//

import Foundation

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
