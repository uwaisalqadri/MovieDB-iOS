//
//  DefaultDetailRepository.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import Foundation
import RxSwift

public struct DefaultDetailRepository {

  fileprivate let remote: RemoteDataSource
  fileprivate let local: LocalDataSource

  init(remote: RemoteDataSource, local: LocalDataSource) {
    self.remote = remote
    self.local = local
  }
}

extension DefaultDetailRepository: DetailRepository {

  func getDetailMovie(idMovie: Int) -> Observable<Movie> {
    return self.remote.getDetailMovie(idMovie: idMovie)
      .map { ObjectMapper.mapMovieResponseToDomain(input: $0) }
  }

  func getMovieCast(idMovie: Int) -> Observable<[Cast]> {
    return self.remote.getMovieCast(idMovie: idMovie)
      .map { ObjectMapper.mapCastResponseToDomain(input: $0) }
  }

  func getMovieTrailer(idMovie: Int) -> Observable<[Video]> {
    return self.remote.getMovieTrailer(idMovie: idMovie)
      .map { ObjectMapper.mapVideoResponseToDomain(input: $0) }
  }

  func getFavoriteMovie() -> Observable<[Movie]> {
    return self.local.getFavoriteMovie()
      .map { ObjectMapper.mapMovieEntitiesToDomains(input: $0) }
  }

  func addFavoriteMovie(from movie: Movie) -> Observable<Bool> {
    let entity = ObjectMapper.mapMovieDomainToEntity(input: movie)
    return self.local.addFavoriteMovie(from: entity)
  }

  func removeFavoriteMovie(idMovie: Int) -> Observable<Bool> {
    return self.local.removeFavoriteMovie(idMovie: idMovie)
  }
}
