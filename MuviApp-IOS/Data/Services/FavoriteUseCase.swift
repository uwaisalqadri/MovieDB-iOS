//
//  FavoriteUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 10/16/21.
//

import RxSwift

protocol FavoriteUseCase {
  func list() -> Observable<[Movie]>
  func add(from movie: Movie)
  func remove(from movie: Movie)
}

class FavoriteInteractor: FavoriteUseCase {
  private let repository: MovieRepository

  init(repository: MovieRepository) {
    self.repository = repository
  }

  func list() -> Observable<[Movie]> {
    repository.getFavoriteMovie()
  }

  func add(from movie: Movie) {
    repository.addFavoriteMovie(from: movie)
  }

  func remove(from movie: Movie) {
    repository.removeFavoriteMovie(from: movie)
  }
}
