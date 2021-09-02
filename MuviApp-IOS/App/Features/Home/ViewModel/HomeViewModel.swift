//
//  HomeViewModel.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {

  let discoverMovie: BehaviorRelay<[Movie]> = .init(value: [Movie]())

  private let disposeBag = DisposeBag()
  private let discoverUseCase: DiscoverUseCase

  init(discoverUseCase: DiscoverUseCase) {
    self.discoverUseCase = discoverUseCase
  }

  func requestDiscoverMovie() {
    discoverUseCase.execute(param: .init(apiKey: "270363a57bb9637a16bdd04f9979e433", language: "en-US", sortBy: .popularity, year: "2020")).subscribe(onNext: { [weak self] result in
      self?.discoverMovie.accept(result)
      print("viewmodel", result)
    }, onError: { error in
      print(error)
    }).disposed(by: disposeBag)
  }
}
