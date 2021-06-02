//
//  GetDetailUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import Foundation
import RxSwift

protocol GetDetailUseCase {
  func execute(idMovie: Int) -> Observable<Movie>
}

class DefaultGetDetailUseCase: GetDetailUseCase {
  private let repository: DetailRepository

  required init(repository: DetailRepository) {
    self.repository = repository
  }

  func execute(idMovie: Int) -> Observable<Movie> {
    return repository.getDetailMovie(idMovie: idMovie)
  }
}
