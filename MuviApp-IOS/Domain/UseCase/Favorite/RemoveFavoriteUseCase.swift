//
//  RemoveFavoriteUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import Foundation
import RxSwift

protocol RemoveFavoriteUseCase {
  func execute(idMovie: Int) -> Observable<Bool>
}

class DefaultRemoveFavoriteUseCase: RemoveFavoriteUseCase {
  private let repository: FavoriteRepository

  required init(repository: FavoriteRepository) {
    self.repository = repository
  }

  func execute(idMovie: Int) -> Observable<Bool> {
    return repository.removeFavoriteMovie(idMovie: idMovie)
  }
}
