//
//  ApiFactory.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation
import Moya

enum BaseApi {
  case movieApi(api: MovieAPI)
}

extension BaseApi: TargetType {
  var baseURL: URL {
    return URL(string: Constants.baseUrl)!
  }

  var path: String {
    switch self {
    case .movieApi(let api):
      return api.path
    }
  }

  var method: Moya.Method {
    switch self {
    case .movieApi(let api):
      return api.method
    }
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    switch self {
    case .movieApi(let api):
      return api.task
    }
  }

  var headers: [String : String]? {
    switch self {
    case .movieApi(let api):
      return api.headers
    }
  }
}

extension BaseApi {
  var endpointClosure: (BaseApi) -> Endpoint {
    return { _ in
      return MoyaProvider.defaultEndpointMapping(for: self)
    }
  }

  var composedUrl: URL? {
    get {
      let endpoint = endpointClosure(self)

      do {
        let url = try endpoint.urlRequest().url
        return url
      } catch {
        return nil
      }
    }
  }
}
