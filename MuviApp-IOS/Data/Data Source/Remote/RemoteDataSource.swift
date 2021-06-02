//
//  RemoteDataSource.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSource: class {

  func getDiscoverMovies(year: String, page: Int) -> Observable<[MovieItem]>

  func searchMovies(query: String) -> Observable<[MovieItem]>

  func getDetailMovie(idMovie: Int) -> Observable<MovieItem>

  func getMovieCast(idMovie: Int) -> Observable<[CastItem]>

  func getMovieTrailer(idMovie: Int) -> Observable<[VideoItem]>
}

class DefaultRemoteDataSource: NSObject {
  private override init() {}

  static let sharedInstance: DefaultRemoteDataSource = DefaultRemoteDataSource()
}

extension DefaultRemoteDataSource: RemoteDataSource {

  func getDiscoverMovies(year: String, page: Int) -> Observable<[MovieItem]> {
    return Observable<[MovieItem]>.create{ observer in
      if let url = URL(string: Constants.baseUrl + getEndpoint(endpoint: .discover, page: page, year: year)) {
        AF.request(url)
          .validate()
          .responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let value):
              observer.onNext(value.results)
              observer.onCompleted()
            case .failure:
              observer.onError(URLError.invalidResponse)
            }
          }
      }
      return Disposables.create()
    }
  }

  func getDetailMovie(idMovie: Int) -> Observable<MovieItem> {
    return Observable<MovieItem>.create { observer in
      if let url = URL(string: Constants.baseUrl + getEndpoint(endpoint: .detail, idMovie: idMovie)) {
        AF.request(url)
          .validate()
          .responseDecodable(of: MovieItem.self) { response in
            switch response.result {
            case .success(let value):
              observer.onNext(value)
              observer.onCompleted()
            case .failure:
              observer.onError(URLError.invalidResponse)
            }
          }
      }

      return Disposables.create()
    }
  }

  func searchMovies(query: String) -> Observable<[MovieItem]> {
    return Observable<[MovieItem]>.create { observer in
      if let url = URL(string: Constants.baseUrl + getEndpoint(endpoint: .search, query: query, adult: false, page: 1)) {
        AF.request(url)
          .validate()
          .responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let value):
              observer.onNext(value.results)
              observer.onCompleted()
            case .failure:
              observer.onError(URLError.invalidResponse)
            }
          }
      }

      return Disposables.create()
    }
  }

  func getMovieCast(idMovie: Int) -> Observable<[CastItem]> {
    return Observable<[CastItem]>.create { observer in
      if let url = URL(string: Constants.baseUrl + getEndpoint(endpoint: .credits, idMovie: idMovie)) {
        AF.request(url)
          .validate()
          .responseDecodable(of: CastResponse.self) { response in
            switch response.result {
            case .success(let value):
              observer.onNext(value.cast)
              observer.onCompleted()
            case .failure:
              observer.onError(URLError.invalidResponse)
            }
          }
      }

      return Disposables.create()
    }
  }

  func getMovieTrailer(idMovie: Int) -> Observable<[VideoItem]> {
    return Observable<[VideoItem]>.create { observer in
      if let url = URL(string: Constants.baseUrl + getEndpoint(endpoint: .videos, idMovie: idMovie))
      {
        AF.request(url)
          .validate()
          .responseDecodable(of: VideoResponse.self) { response in
            switch response.result {
            case .success(let value):
              observer.onNext(value.results)
              observer.onCompleted()
            case .failure:
              observer.onError(URLError.invalidResponse)
            }
          }
      }

      return Disposables.create()
    }
  }
}
