//
//  DetailAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import Foundation
import RealmSwift

protocol DetailAssembler {
  func resolve() -> DetailViewController
  func resolve() -> DetailViewModel
  func resolve() -> AddFavoriteUseCase
  func resolve() -> GetDetailUseCase
  func resolve() -> GetCastUseCase
  func resolve() -> GetVideoUseCase
  func resolve() -> DetailRepository
}

extension DetailAssembler where Self: Assembler {

  func resolve() -> DetailViewController {
    return DetailViewController(idMovie: 0, viewModel: resolve())
  }

  func resolve() -> DetailViewModel {
    return DetailViewModel(
      getDetailUseCase: resolve(),
      getMovieCastUseCase: resolve(),
      getMovieTrailerUseCase: resolve(),
      addToFavoriteUseCase: resolve()
    )
  }

  func resolve() -> AddFavoriteUseCase {
    return DefaulAddFavoriteUseCase(repository: resolve())
  }

  func resolve() -> GetDetailUseCase {
    return DefaultGetDetailUseCase(repository: resolve())
  }

  func resolve() -> GetCastUseCase {
    return DefaultGetCastUseCase(repository: resolve())
  }

  func resolve() -> GetVideoUseCase {
    return DefaultGetVideoUseCase(repository: resolve())
  }

  func resolve() -> DetailRepository {
    let realm = try? Realm()
    let local = DefaultLocalDataSource.sharedInstance(realm)
    let remote = DefaultRemoteDataSource.sharedInstance
    return DefaultDetailRepository(remote: remote, local: local)
  }
}
