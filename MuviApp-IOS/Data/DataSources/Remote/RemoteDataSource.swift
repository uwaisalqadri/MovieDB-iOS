//
//  RemoteDataSource.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import RxSwift
import Alamofire

protocol RemoteDataSource {
  func getDiscover(param: DiscoverParamater) -> Observable<[Movie]>
  func getDetail(movieId: Int) -> Observable<Movie>
  func getSearch(param: SearchParamater) -> Observable<[Movie]>
}

struct DefaultRemoteDataSource: RemoteDataSource {
  func getDiscover(param: DiscoverParamater) -> Observable<[Movie]> {
    return NetworkService.shared.connect(api: .movieApi(api: .discover(param: param)), mappableType: MovieResponse.self).compactMap { $0.results }
  }

  func getDetail(movieId: Int) -> Observable<Movie> {
    return NetworkService.shared.connect(api: .movieApi(api: .detail(id: movieId)), mappableType: MovieItem.self).compactMap { $0 }
  }

  func getSearch(param: SearchParamater) -> Observable<[Movie]> {
    return NetworkService.shared.connect(api: .movieApi(api: .search(param: param)), mappableType: MovieResponse.self).compactMap { $0.results }
  }

}

