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

//  let detailMovie = BehaviorRelay<Movie>(valu)

  private let disposeBag = DisposeBag()
  private let detailUseCase: DetailUseCase
  private let idMovie: Int

  init(detailUseCase: DetailUseCase, idMovie: Int) {
    self.detailUseCase = detailUseCase
    self.idMovie = idMovie
  }

  func requestDetail() {
    detailUseCase.execute(param: .init(movieId: idMovie)).subscribe(onNext: { result in
      print(result.title)
    }, onError: { error in
      print(error)
    }).disposed(by: disposeBag)
  }
}
