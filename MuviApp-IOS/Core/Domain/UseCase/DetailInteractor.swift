//
//  DetailInteractor.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 03/05/21.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    func getDetailMovie(idMovie: Int) -> Observable<Movie>
    func getMovieCast(idMovie: Int) -> Observable<[Cast]>
    func getMovieTrailer(idMovie: Int) -> Observable<[Video]>
}


class DetailInteractor: DetailUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDetailMovie(idMovie: Int) -> Observable<Movie> {
        return repository.getDetailMovie(idMovie: idMovie)
    }
    
    func getMovieCast(idMovie: Int) -> Observable<[Cast]> {
        return repository.getMovieCast(idMovie: idMovie)
    }
    
    func getMovieTrailer(idMovie: Int) -> Observable<[Video]> {
        return repository.getMovieTrailer(idMovie: idMovie)
    }
}
