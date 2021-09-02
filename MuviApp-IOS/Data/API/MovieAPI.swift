//
//  MovieAPI.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation
import Moya

enum MovieAPI {
  case search(param: SearchParamater)
  case discover(param: DiscoverParamater)
  case detail(id: Int)
}

extension MovieAPI: TargetType {

  var path: String {
    switch self {
    case .search:
      return "search/movie"
    case .discover:
      return "discover/movie"
    case .detail(let movieId):
      return "movie/\(movieId)"
    }
  }

  var method: Moya.Method {
    return .get
  }

  var task: Task {
    switch self {
    case .discover(let discoverParameter):
      return .requestParameters(parameters: discoverParameter.parameters ?? [:], encoding: URLEncoding.default)

    case .search(let searchParameter):
      return .requestParameters(parameters: searchParameter.parameters ?? [:], encoding: URLEncoding.default)

    case .detail:
      return .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }
  }


  // below is just a stub
  var headers: [String : String]? { nil }
  var baseURL: URL { URL(string: "")! }
  var sampleData: Foundation.Data { Data() }

}
