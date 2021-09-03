//
//  UpComingUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 03/09/21.
//

import Foundation
import RxSwift

protocol UpComingUseCase {
  func execute(param: DiscoverParamater) -> Observable<[Movie]>
}

class UpComing: UpComingUseCase {
  private let repository: MovieRepository

  init(repository: MovieRepository) {
    self.repository = repository
  }

  func execute(param: DiscoverParamater) -> Observable<[Movie]> {
    return repository.getDiscover(discoverParam: param)
  }
}
