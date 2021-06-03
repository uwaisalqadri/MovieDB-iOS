//
//  PopularAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import Foundation

protocol PopularAssembler {
  func resolve() -> PopularViewController
  func resolve() -> PopularViewModel
  func resolve() -> GetSearchUseCase
  func resolve() -> SearchRepository
}

extension PopularAssembler where Self: Assembler {
  func resolve() -> PopularViewController {
    return PopularViewController(viewModel: resolve())
  }

  func resolve() -> PopularViewModel {
    return PopularViewModel(getSearchMovieUseCase: resolve())
  }

  func resolve() -> GetSearchUseCase {
    return DefaultGetSearchUseCase(repository: resolve())
  }

  func resolve() -> SearchRepository {
    let remote = DefaultRemoteDataSource.sharedInstance
    return DefaultSearchRepository(remote: remote)
  }
}
