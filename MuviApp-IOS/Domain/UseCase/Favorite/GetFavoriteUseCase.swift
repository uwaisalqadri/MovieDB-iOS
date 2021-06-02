//
//  GetFavoriteUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 03/05/21.
//

import Foundation
import RxSwift

protocol GetFavoriteUseCase {
  func execute() -> Observable<[Movie]>
}

class DefaultGetFavoriteUseCase: GetFavoriteUseCase {

  private let repository: FavoriteRepository

  required init(repository: FavoriteRepository) {
    self.repository = repository
  }

  func execute() -> Observable<[Movie]> {
    return repository.getFavoriteMovie()
  }
}
