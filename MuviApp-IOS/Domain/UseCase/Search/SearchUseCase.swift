//
//  SearchUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation
import RxSwift

protocol SearchUseCase {
  func execute(param: SearchParamater) -> Observable<[Movie]>
}

class Search: SearchUseCase {
  private let repository: MovieRepository

  init(repository: MovieRepository) {
    self.repository = repository
  }

  func execute(param: SearchParamater) -> Observable<[Movie]> {
    return repository.getSearch(searchParam: param)
  }
}
