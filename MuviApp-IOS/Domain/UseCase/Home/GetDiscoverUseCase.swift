//
//  GetDiscoverMoviesUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation
import RxSwift


protocol GetDiscoverUseCase {
  func execute(year: String, page: Int) -> Observable<[Movie]>
}

class DefaultGetDiscoverUseCase: GetDiscoverUseCase {
  private let repository: HomeRepository
 
  required init(repository: HomeRepository) {
    self.repository = repository
  }

  func execute(year: String, page: Int) -> Observable<[Movie]> {
    return repository.getDiscoverMovies(year: year, page: page)
  }

}
