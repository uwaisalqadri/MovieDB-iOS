//
//  PopularAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit

protocol SearchAssembler {
  func resolve() -> SearchViewController
  func resolve() -> SearchNavigator

  func resolve() -> SearchViewModel
  func resolve() -> SearchUseCase
}

extension SearchAssembler where Self: Assembler {
  func resolve() -> SearchNavigator {
    return DefaultPopularNavigator(assembler: self)
  }

  func resolve() -> SearchViewController {
    return SearchViewController(navigator: resolve(), viewModel: resolve())
  }

  func resolve() -> SearchViewModel {
    return SearchViewModel(searchUseCase: resolve())
  }

  func resolve() -> SearchUseCase {
    return Search(repository: resolve())
  }
}
