//
//  SearchViewModel.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {

  let searchMovies: BehaviorRelay<[Movie]> = .init(value: [Movie]())

  private let disposeBag = DisposeBag()
  private let searchUseCase: SearchUseCase

  var searchParam: SearchParamater?

  init(searchUseCase: SearchUseCase) {
    self.searchUseCase = searchUseCase
  }

  func requestSearch() {

    guard let param = searchParam else { return }

    searchUseCase.execute(param: .init(query: param.query)).subscribe(onNext: { [weak self] result in
      self?.searchMovies.accept(result)
    }).disposed(by: disposeBag)
  }
}
