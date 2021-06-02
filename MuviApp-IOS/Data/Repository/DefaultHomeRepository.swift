//
//  DefaultHomeRepository.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation
import RxSwift

public struct DefaultHomeRepository {

  fileprivate let remote: RemoteDataSource

  init(remote: RemoteDataSource) {
    self.remote = remote
  }
}

extension DefaultHomeRepository: HomeRepository {
  
  func getDiscoverMovies(year: String, page: Int) -> Observable<[Movie]> {
    return self.remote.getDiscoverMovies(year: year, page: page)
      .map{ ObjectMapper.mapMoviesResponseToDomain(input: $0) }
  }
}
