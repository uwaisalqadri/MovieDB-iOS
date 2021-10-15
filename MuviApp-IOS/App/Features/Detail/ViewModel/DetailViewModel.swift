//
//  DetailViewModel.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel {

  let detailMovie = PublishRelay<Movie>()
  let creditMovie = BehaviorRelay<[Credit]>(value: [Credit]())
  let videoMovie = BehaviorRelay<[Video]>(value: [Video]())

  private let disposeBag = DisposeBag()
  private let detailUseCase: DetailUseCase
  private let creditUseCase: CreditUseCase
  private let videoUseCase: VideoUseCase
  private let idMovie: Int

  init(detailUseCase: DetailUseCase, creditUseCase: CreditUseCase, videoUseCase: VideoUseCase, idMovie: Int) {
    self.detailUseCase = detailUseCase
    self.creditUseCase = creditUseCase
    self.videoUseCase = videoUseCase
    self.idMovie = idMovie
  }

  func requestDetailMovie() {
    detailUseCase.execute(param: .init(movieId: idMovie))
      .subscribe(onNext: { [weak self] result in
        self?.detailMovie.accept(result)
      }).disposed(by: disposeBag)
  }

  func requestCreditMovie() {
    creditUseCase.execute(param: .init(movieId: idMovie))
      .subscribe(onNext: { [weak self] result in
        self?.creditMovie.accept(result)
      }).disposed(by: disposeBag)
  }

  func requestVideoMovie() {
    videoUseCase.execute(param: .init(movieId: idMovie))
      .subscribe(onNext: { [weak self] result in
        self?.videoMovie.accept(result)
      }).disposed(by: disposeBag)
  }
}
