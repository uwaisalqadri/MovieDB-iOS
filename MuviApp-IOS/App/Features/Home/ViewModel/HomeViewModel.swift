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

  let popularMovies: BehaviorRelay<[Movie]> = .init(value: [Movie]())
  let upComingMovies: BehaviorRelay<[Movie]> = .init(value: [Movie]())
  let bannerMovies: BehaviorRelay<[Movie]> = .init(value: [Movie]())

  private let disposeBag = DisposeBag()
  private let popularUseCase: PopularUseCase
  private let upComingUseCase: UpComingUseCase

  private let popularParam: DiscoverParamater = .init(sortBy: .popularity, year: "2021")
  private let upComingParam: DiscoverParamater = .init(sortBy: .popularity, year: "2022")
  private let bannerParam: DiscoverParamater = .init(sortBy: .releaseDate, year: "2021")

  init(popularUseCase: PopularUseCase, upComingUseCase: UpComingUseCase) {
    self.popularUseCase = popularUseCase
    self.upComingUseCase = upComingUseCase
  }

  func requestPopularMovie() {
    popularUseCase.execute(param: popularParam).subscribe(onNext: { [weak self] result in
      self?.popularMovies.accept(Array(result[0...9]))
    }).disposed(by: disposeBag)
  }

  func requestUpComingMovie() {
    upComingUseCase.execute(param: upComingParam).subscribe(onNext: { [weak self] result in
      self?.upComingMovies.accept(Array(result[0...9]))
    }).disposed(by: disposeBag)
  }

  func requestBannerMovie() {
    popularUseCase.execute(param: bannerParam).subscribe(onNext: { [weak self] result in
      self?.bannerMovies.accept(Array(result[0...2]))
    }).disposed(by: disposeBag)
  }
}
