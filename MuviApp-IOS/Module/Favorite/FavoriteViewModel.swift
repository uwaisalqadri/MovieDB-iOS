//
//  ViewModel.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation
import RxSwift


class FavoriteViewModel: NSObject {

  private let disposeBag = DisposeBag()
  private let getFavoriteMovieUseCase: GetFavoriteUseCase
  private let removeFavoriteUseCase: RemoveFavoriteUseCase

  var favMovies = PublishSubject<[Movie]>()
  var errorMessage: Box<String> = Box("")

  init(getFavoriteMovieUseCase: GetFavoriteUseCase, removeFavoriteUseCase: RemoveFavoriteUseCase) {
    self.getFavoriteMovieUseCase = getFavoriteMovieUseCase
    self.removeFavoriteUseCase = removeFavoriteUseCase
  }

  func getFavoriteMovie() {
    getFavoriteMovieUseCase.execute()
      .observe(on: MainScheduler.instance)
      .subscribe{ result in
        print("from viewModel directly \(result)")
        self.favMovies.onNext(result)
        self.favMovies.onCompleted()
      } onError: { error in
        self.errorMessage.value = String(describing: error)
      }.disposed(by: disposeBag)
  }
}
