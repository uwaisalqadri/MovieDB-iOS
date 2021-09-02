//
//  ApiConfiguration.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation

struct APIConfiguration {
  var baseURL: URL
}

extension APIConfiguration {

  static func configAPI() -> APIConfiguration {
    APIConfiguration(baseURL: URL(string: "https://api.themoviedb.org/3/")!)
  }

}
