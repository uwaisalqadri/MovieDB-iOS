//
//  CreditUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 05/10/21.
//

import RxSwift

protocol CreditUseCase {
  func execute(param: DetailParameter) -> Observable<Movie>
}

class CastInteractor: DetailUseCase {
  private let repository: MovieRepository

  init(repository: MovieRepository) {
    self.repository = repository
  }

  func execute(param: DetailParameter) -> Observable<Movie> {
    return repository.getDetail(detailParam: param)
  }
}
