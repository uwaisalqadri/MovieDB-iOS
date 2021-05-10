//
//  RemoteDataSource.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: class {
    
    func getDiscoverMovies(year: String) -> Observable<[MovieItem]>
    
//    func getGenres() -> Observable<[MovieItem]>
//
    func searchMovies(query: String) -> Observable<[MovieItem]>

    func getDetailMovie(idMovie: Int) -> Observable<MovieItem>

    func getMovieCast(idMovie: Int) -> Observable<[CastItem]>

    func getMovieTrailer(idMovie: Int) -> Observable<[VideoItem]>
}

final class RemoteDataSource: NSObject {
    private override init() {}
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getDiscoverMovies(year: String) -> Observable<[MovieItem]> {
        return Observable<[MovieItem]>.create{ observer in
            if let url =
                URL(string: Endpoints.Gets.discover.url + "?api_key=\(Constants.apiKey)&languange=\(Constants.lang)&sort_by=\(Constants.sortBy)&include_adult=false&page=1&year=\(year)")
            {
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
            if let url = URL(string: Endpoints.Gets.detail.url + "\(idMovie)?api_key=\(Constants.apiKey)&language=\(Constants.lang)") {
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
            if let url = URL(string: Endpoints.Gets.search.url + "?api_key=\(Constants.apiKey)&languange=\(Constants.lang)&page=1&query=\(query)")
            {
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
            if let url = URL(string: Endpoints.Gets.detail.url + "\(idMovie)/credits?api_key=\(Constants.apiKey)&language=\(Constants.lang)")
            {
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
            if let url = URL(string: Endpoints.Gets.detail.url + "\(idMovie)/videos?api_key=\(Constants.apiKey)&language=\(Constants.lang)")
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
