//
//  HomeAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import Foundation

protocol HomeAssembler {
  func resolve() -> HomeViewController
  func resolve() -> HomeViewModel
  func resolve() -> GetDiscoverUseCase
  func resolve() -> HomeRepository
}

extension HomeAssembler where Self: Assembler {

  func resolve() -> HomeViewController {
    return HomeViewController(viewModel: resolve())
  }

  func resolve() -> HomeViewModel {
    return HomeViewModel(getDiscoverMovieUseCase: resolve())
  }

  func resolve() -> GetDiscoverUseCase {
    return DefaultGetDiscoverUseCase(repository: resolve())
  }

  func resolve() -> HomeRepository {
    let remote = DefaultRemoteDataSource.sharedInstance
    return DefaultHomeRepository(remote: remote)
  }
}
