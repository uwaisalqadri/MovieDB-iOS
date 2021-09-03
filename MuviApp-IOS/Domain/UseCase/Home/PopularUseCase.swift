//
//  PopularUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation
import RxSwift

protocol PopularUseCase {
  func execute(param: DiscoverParamater) -> Observable<[Movie]>
}

class Popular: PopularUseCase {
  private let repository: MovieRepository

  init(repository: MovieRepository) {
    self.repository = repository
  }

  func execute(param: DiscoverParamater) -> Observable<[Movie]> {
    return repository.getDiscover(discoverParam: param)
  }
}
