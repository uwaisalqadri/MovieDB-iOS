//
//  MovieUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation
import RxSwift


protocol MovieUseCase {
    func getDiscoverMovies(year: String) -> Observable<[Movie]>
    func getDetailMovie(idMovie: Int) -> Observable<Movie>
}

class MovieInteractor: MovieUseCase {
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDiscoverMovies(year: String) -> Observable<[Movie]> {
        return repository.getDiscoverMovies(year: year)
    }
    
    func getDetailMovie(idMovie: Int) -> Observable<Movie> {
        return repository.getDetailMovie(idMovie: idMovie)
    }
    
}
