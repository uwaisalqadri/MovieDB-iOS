//
//  RemoteDataSource.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import RxSwift
import Alamofire

protocol RemoteDataSource {
  func getDiscover(param: DiscoverParamater) -> Observable<[MovieItem]>
  func getDetail(param: DetailParameter) -> Observable<MovieItem>
  func getSearch(param: SearchParamater) -> Observable<[MovieItem]>
  func getVideo(param: DetailParameter) -> Observable<[VideoItem]>
  func getCredit(param: DetailParameter) -> Observable<[CreditItem]>
}

struct DefaultRemoteDataSource: RemoteDataSource {
  func getDiscover(param: DiscoverParamater) -> Observable<[MovieItem]> {
    return NetworkService.shared.connect(api: .movieApi(api: .discover(param: param)), mappableType: MovieResponse.self).compactMap { $0._results }
  }

  func getDetail(param: DetailParameter) -> Observable<MovieItem> {
    return NetworkService.shared.connect(api: .movieApi(api: .detail(param: param)), mappableType: MovieItem.self).compactMap { $0 }
  }

  func getSearch(param: SearchParamater) -> Observable<[MovieItem]> {
    return NetworkService.shared.connect(api: .movieApi(api: .search(param: param)), mappableType: MovieResponse.self).compactMap { $0._results }
  }

  func getVideo(param: DetailParameter) -> Observable<[VideoItem]> {
    return NetworkService.shared.connect(api: .movieApi(api: .video(param: param)), mappableType: VideoResponse.self).compactMap { $0._results }
  }

  func getCredit(param: DetailParameter) -> Observable<[CreditItem]> {
    return NetworkService.shared.connect(api: .movieApi(api: .credits(param: param)), mappableType: CreditResponse.self).compactMap { $0._cast }
  }

}

