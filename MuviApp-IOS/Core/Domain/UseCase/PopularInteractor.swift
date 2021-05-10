//
//  PopularUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 03/05/21.
//

import Foundation
import RxSwift

protocol PopularUseCase {
    func searchMovies(query: String) -> Observable<[Movie]>
}

class PopularInteractor: PopularUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func searchMovies(query: String) -> Observable<[Movie]> {
        return repository.searchMovies(query: query)
    }
}
