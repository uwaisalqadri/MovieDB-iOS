//
//  SearchParameter.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation

struct SearchParamater: Encodable {
  let api_key: String
  let language: String
  let query: String
  let page: Int

  init(apiKey: String, query: String, language: String, page: Int = 1) {
    self.api_key = apiKey
    self.language = language
    self.query = query
    self.page = page
  }
}
