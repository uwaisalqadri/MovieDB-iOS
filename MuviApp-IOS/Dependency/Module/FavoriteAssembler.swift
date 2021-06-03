//
//  FavoriteAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import Foundation
import RealmSwift

protocol FavoriteAssembler {
  func resolve() -> FavoriteViewController
  func resolve() -> FavoriteViewModel
  func resolve() -> GetFavoriteUseCase
  func resolve() -> RemoveFavoriteUseCase
  func resolve() -> FavoriteRepository
}

extension FavoriteAssembler where Self: Assembler {

  func resolve() -> FavoriteViewController {
    return FavoriteViewController(viewModel: resolve())
  }

  func resolve() -> FavoriteViewModel {
    return FavoriteViewModel(
      getFavoriteMovieUseCase: resolve(),
      removeFavoriteUseCase: resolve()
    )
  }

  func resolve() -> GetFavoriteUseCase {
    return DefaultGetFavoriteUseCase(repository: resolve())
  }

  func resolve() -> RemoveFavoriteUseCase {
    return DefaultRemoveFavoriteUseCase(repository: resolve())
  }

  func resolve() -> FavoriteRepository {
    let realm = try? Realm()
    let local = DefaultLocalDataSource.sharedInstance(realm)
    return DefaultFavoriteRepository(local: local)
  }
}
