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
  var query = ""

  init(searchUseCase: SearchUseCase) {
    self.searchUseCase = searchUseCase
  }


  func requestSearch() {
    searchUseCase.execute(param: .init(query: query, language: "")).subscribe(onNext: { [weak self] result in
      self?.searchMovies.accept(result)
    }, onError: { error in

    }).disposed(by: disposeBag)
  }
}
