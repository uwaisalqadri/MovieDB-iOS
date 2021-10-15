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
  case detail(param: DetailParameter)
  case credits(param: DetailParameter)
  case video(param: DetailParameter)
}

extension MovieAPI: TargetType {

  var path: String {
    switch self {
    case .search:
      return "search/movie"
    case .discover:
      return "discover/movie"
    case .detail(let param):
      return "movie/\(param.movie_id)"
    case .credits(let param):
      return "movie/\(param.movie_id)/credits"
    case .video(let param):
      return "movie/\(param.movie_id)/video"
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

    case .detail(let detailParameter):
      return .requestParameters(parameters: detailParameter.parameters ?? [:], encoding: URLEncoding.default)

    case .credits(let detailParamater):
      return .requestParameters(parameters: detailParamater.parameters ?? [:], encoding: URLEncoding.default)

    case .video(let detailParameter):
      return .requestParameters(parameters: detailParameter.parameters ?? [:], encoding: URLEncoding.default)
    }

  }


  // below is just a stub
  var headers: [String : String]? { nil }
  var baseURL: URL { URL(string: "")! }
  var sampleData: Foundation.Data { Data() }

}
