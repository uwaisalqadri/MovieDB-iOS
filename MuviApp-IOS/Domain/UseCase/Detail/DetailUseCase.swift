//
//  DetailUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import RxSwift

protocol DetailUseCase {
  func execute(param: DetailParameter) -> Observable<Movie>
}

class DetailInteractor: DetailUseCase {
  private let repository: MovieRepository

  init(repository: MovieRepository) {
    self.repository = repository
  }

  func execute(param: DetailParameter) -> Observable<Movie> {
    return repository.getDetail(detailParam: param)
  }
}
