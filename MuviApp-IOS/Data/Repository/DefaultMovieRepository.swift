//
//  DefaultMovieRepository.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation
import RxSwift

struct DefaultMovieRepository: MovieRepository {
  fileprivate let remoteDataSource: RemoteDataSource
  fileprivate let localDataSource: LocalDataSource

  init(remoteDataSource: RemoteDataSource, localDataSource: LocalDataSource) {
    self.remoteDataSource = remoteDataSource
    self.localDataSource = localDataSource
  }

  func getDiscover(discoverParam: DiscoverParamater) -> Observable<[Movie]> {
    return remoteDataSource.getDiscover(param: discoverParam).map { $0 }
  }

  func getDetail(detailParam: DetailParameter) -> Observable<Movie> {
    return remoteDataSource.getDetail(param: detailParam).map { $0 }
  }

  func getSearch(searchParam: SearchParamater) -> Observable<[Movie]> {
    return remoteDataSource.getSearch(param: searchParam).map { $0 }
  }

  func getVideo(detailParam: DetailParameter) -> Observable<[Video]> {
    return remoteDataSource.getVideo(param: detailParam).map { $0 }
  }

  func getCredit(detailParam: DetailParameter) -> Observable<[Credit]> {
    return remoteDataSource.getCredit(param: detailParam).map { $0 }
  }

  func getFavoriteMovie() -> Observable<[Movie]> {
    return localDataSource.getFavoriteMovie().map { $0 }
  }

  func addFavoriteMovie(from movie: Movie) {
    guard let movieEntity = movie as? MovieEntity else { return }
    localDataSource.addFavoriteMovie(from: movieEntity)
  }

  func removeFavoriteMovie(from movie: Movie) {
    guard let movieEntity = movie as? MovieEntity else { return }
    localDataSource.removeFavoriteMovie(from: movieEntity)
  }

}
