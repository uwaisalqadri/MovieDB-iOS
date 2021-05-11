//
//  MovieRepository.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation
import RxSwift

protocol MovieRepositoryProtocol {
    func getDiscoverMovies(year: String, page: Int) -> Observable<[Movie]>
    func getDetailMovie(idMovie: Int) -> Observable<Movie>
    func getMovieCast(idMovie: Int) -> Observable<[Cast]>
    func getMovieTrailer(idMovie: Int) -> Observable<[Video]>
    func searchMovies(query: String) -> Observable<[Movie]>
    
    func getFavoriteMovie() -> Observable<[Movie]>
    func addFavoriteMovie(from movie: Movie) -> Observable<Bool>
    func removeFavoriteMovie(idMovie: Int) -> Observable<Bool>
}


final class MovieRepository: NSObject {
    typealias MovieInstance = (LocaleDataSource, RemoteDataSource) -> MovieRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: MovieInstance = { localeRepo, remoteRepo in
        return MovieRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    
    func getDiscoverMovies(year: String, page: Int) -> Observable<[Movie]> {
        return self.remote.getDiscoverMovies(year: year, page: page)
            .map{ ObjectMapper.mapMoviesResponseToDomain(input: $0) }
    }
    
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
    
    func searchMovies(query: String) -> Observable<[Movie]> {
        return self.remote.searchMovies(query: query)
            .map { ObjectMapper.mapMoviesResponseToDomain(input: $0) }
    }
    
    func getFavoriteMovie() -> Observable<[Movie]> {
        return self.locale.getFavoriteMovie()
            .map { ObjectMapper.mapMovieEntitiesToDomains(input: $0) }
    }
    
    func addFavoriteMovie(from movie: Movie) -> Observable<Bool> {
        let entity = ObjectMapper.mapMovieDomainToEntity(input: movie)
        return self.locale.addFavoriteMovie(from: entity)
    }
    
    func removeFavoriteMovie(idMovie: Int) -> Observable<Bool> {
        return self.locale.removeFavoriteMovie(idMovie: idMovie)
    }
}
