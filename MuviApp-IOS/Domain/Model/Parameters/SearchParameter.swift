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

  init(query: String, page: Int = 1) {
    self.api_key = Constants.token
    self.language = Constants.enUs
    self.query = query
    self.page = page
  }
}
