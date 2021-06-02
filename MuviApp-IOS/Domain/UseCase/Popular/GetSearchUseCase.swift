//
//  GetSearchUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 03/05/21.
//

import Foundation
import RxSwift

protocol GetSearchUseCase {
  func execute(query: String) -> Observable<[Movie]>
}

class DefaultGetSearchUseCase: GetSearchUseCase {

  private let repository: SearchRepository

  required init(repository: SearchRepository) {
    self.repository = repository
  }

  func execute(query: String) -> Observable<[Movie]> {
    return repository.searchMovies(query: query)
  }
}
