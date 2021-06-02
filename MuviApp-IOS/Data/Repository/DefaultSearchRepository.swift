//
//  DefaultSearchRepository.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import Foundation
import RxSwift

public struct DefaultSearchRepository {

  fileprivate let remote: RemoteDataSource

  init(remote: RemoteDataSource) {
    self.remote = remote
  }
}

extension DefaultSearchRepository: SearchRepository {
  func searchMovies(query: String) -> Observable<[Movie]> {
    return self.remote.searchMovies(query: query)
      .map { ObjectMapper.mapMoviesResponseToDomain(input: $0) }
  }
}
