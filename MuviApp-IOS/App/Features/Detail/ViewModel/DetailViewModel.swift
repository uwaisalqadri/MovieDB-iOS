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

//  let detailMovie: BehaviorRelay<Movie> = .init(value: Movie)

  private let detailUseCase: DetailUseCase
  private let disposeBag = DisposeBag()

  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
  }

  func requestDetail() {
    detailUseCase.execute(param: .init(language: "", movieId: 0)).subscribe(onNext: { [weak self] result in
      print(result)
    }, onError: { error in
      print(error)
    }).disposed(by: disposeBag)
  }
}
