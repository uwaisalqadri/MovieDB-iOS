//
//  FavoriteViewModel.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 10/16/21.
//

import Foundation
import RxSwift
import RxCocoa

class FavoriteViewModel {

  let favoriteMovies: BehaviorRelay<[Movie]> = .init(value: [Movie]())

  private let disposeBag = DisposeBag()
  private let favoriteUseCase: FavoriteUseCase

  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }

  func requestFavoriteMovie() {
    favoriteUseCase.list().subscribe(onNext: { [weak self] result in
      self?.favoriteMovies.accept(result)
    }).disposed(by: disposeBag)
  }

  func addFavoriteMovie(from movie: Movie) {
    favoriteUseCase.add(from: movie)
  }

  func removeFavoriteMovie(from movie: Movie) {
    favoriteUseCase.remove(from: movie)
  }

}
