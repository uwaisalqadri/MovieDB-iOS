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
  private let discoverParam: DiscoverParamater = .init(language: "en-US", sortBy: .popularity, year: "2020")

  init(discoverUseCase: DiscoverUseCase) {
    self.discoverUseCase = discoverUseCase
  }

  func requestDiscoverMovie() {
    discoverUseCase.execute(param: discoverParam).subscribe(onNext: { [weak self] result in
      self?.discoverMovie.accept(result)
      print("viewmodel", result)
    }).disposed(by: disposeBag)
  }
}
