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
  func getDetail(param: DetailParameter) -> Observable<Movie>
  func getSearch(param: SearchParamater) -> Observable<[Movie]>
  func getVideo(param: DetailParameter) -> Observable<[Video]>
  func getCredit(param: DetailParameter) -> Observable<[Credit]>
}

struct DefaultRemoteDataSource: RemoteDataSource {
  func getDiscover(param: DiscoverParamater) -> Observable<[Movie]> {
    return NetworkService.shared.connect(api: .movieApi(api: .discover(param: param)), mappableType: MovieResponse.self).compactMap { $0.results }
  }

  func getDetail(param: DetailParameter) -> Observable<Movie> {
    return NetworkService.shared.connect(api: .movieApi(api: .detail(param: param)), mappableType: MovieItem.self).compactMap { $0 }
  }

  func getSearch(param: SearchParamater) -> Observable<[Movie]> {
    return NetworkService.shared.connect(api: .movieApi(api: .search(param: param)), mappableType: MovieResponse.self).compactMap { $0.results }
  }

  func getVideo(param: DetailParameter) -> Observable<[Video]> {
    return NetworkService.shared.connect(api: .movieApi(api: .video(param: param)), mappableType: VideoResponse.self).compactMap { $0.results }
  }

  func getCredit(param: DetailParameter) -> Observable<[Credit]> {
    return NetworkService.shared.connect(api: .movieApi(api: .credits(param: param)), mappableType: CreditResponse.self).compactMap { $0.cast }
  }

}

