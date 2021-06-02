//
//  AddFavoriteUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import Foundation
import RxSwift

protocol AddFavoriteUseCase {
  func execute(from movie: Movie) -> Observable<Bool>
}

class DefaulAddFavoriteUseCase: AddFavoriteUseCase {

  private let repository: DetailRepository

  required init(repository: DetailRepository) {
    self.repository = repository
  }

  func execute(from movie: Movie) -> Observable<Bool> {
    return repository.addFavoriteMovie(from: movie)
  }
}
