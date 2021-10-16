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

  init(remoteDataSource: RemoteDataSource) {
    self.remoteDataSource = remoteDataSource
  }

  func getDiscover(discoverParam: DiscoverParamater) -> Observable<[Movie]> {
    return remoteDataSource.getDiscover(param: discoverParam)
  }

  func getDetail(detailParam: DetailParameter) -> Observable<Movie> {
    return remoteDataSource.getDetail(param: detailParam)
  }

  func getSearch(searchParam: SearchParamater) -> Observable<[Movie]> {
    return remoteDataSource.getSearch(param: searchParam)
  }

  func getVideo(detailParam: DetailParameter) -> Observable<[Video]> {
    return remoteDataSource.getVideo(param: detailParam)
  }

  func getCredit(detailParam: DetailParameter) -> Observable<[Credit]> {
    return remoteDataSource.getCredit(param: detailParam)
  }

}