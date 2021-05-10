//
//  FavoriteUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 03/05/21.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getFavoriteMovie() -> Observable<[Movie]>
    func addFavoriteMovie(from movie: Movie) -> Observable<Bool>
    func removeFavoriteMovie(idMovie: Int) -> Observable<Bool>
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteMovie() -> Observable<[Movie]> {
        return repository.getFavoriteMovie()
    }
    
    func addFavoriteMovie(from movie: Movie) -> Observable<Bool> {
        return repository.addFavoriteMovie(from: movie)
    }
    
    func removeFavoriteMovie(idMovie: Int) -> Observable<Bool> {
        return repository.removeFavoriteMovie(idMovie: idMovie)
    }
}
