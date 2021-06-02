//
//  DefaultFavoriteRepository.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import Foundation
import RxSwift

public struct DefaultFavoriteRepository {

  fileprivate let local: LocalDataSource

  init(local: LocalDataSource) {
    self.local = local
  }
}

extension DefaultFavoriteRepository: FavoriteRepository {

  func getFavoriteMovie() -> Observable<[Movie]> {
    return self.local.getFavoriteMovie()
      .map { ObjectMapper.mapMovieEntitiesToDomains(input: $0) }
  }

  func removeFavoriteMovie(idMovie: Int) -> Observable<Bool> {
    return self.local.removeFavoriteMovie(idMovie: idMovie)
  }
}
