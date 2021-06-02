//
//  GetCastUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import Foundation
import RxSwift

protocol GetCastUseCase {
  func execute(idMovie: Int) -> Observable<[Cast]>
}

class DefaultGetCastUseCase: GetCastUseCase {
  private let repository: DetailRepository

  required init(repository: DetailRepository) {
    self.repository = repository
  }

  func execute(idMovie: Int) -> Observable<[Cast]> {
    return repository.getMovieCast(idMovie: idMovie)
  }
}
