//
//  HomeAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit
import RealmSwift

protocol HomeAssembler {
  func resolve() -> HomeNavigator
  func resolve() -> HomeTabBarViewController
  func resolve() -> HomeViewController

  func resolve() -> HomeViewModel
  func resolve() -> PopularUseCase
  func resolve() -> UpComingUseCase
  func resolve() -> MovieRepository

  func resolve() -> RemoteDataSource
  func resolve() -> LocalDataSource
}

extension HomeAssembler where Self: Assembler {
  func resolve() -> HomeTabBarViewController {
    return HomeTabBarViewController(navigator: resolve())
  }

  func resolve() -> HomeViewController {
    return HomeViewController(navigator: resolve(), viewModel: resolve())
  }

  func resolve() -> HomeNavigator {
    return DefaultHomeNavigator(assembler: self)
  }

  func resolve() -> HomeViewModel {
    return HomeViewModel(popularUseCase: resolve(), upComingUseCase: resolve())
  }

  func resolve() -> PopularUseCase {
    return Popular(repository: resolve())
  }

  func resolve() -> UpComingUseCase {
    return UpComing(repository: resolve())
  }

  func resolve() -> MovieRepository {
    return DefaultMovieRepository(remoteDataSource: resolve(), localDataSource: resolve())
  }

  func resolve() -> RemoteDataSource {
    return DefaultRemoteDataSource()
  }

  func resolve() -> LocalDataSource {
    let realm = try? Realm()
    return DefaultLocalDataSource(realm: realm)
  }
}
