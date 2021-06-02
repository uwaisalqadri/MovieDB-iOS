//
//  GetVideoUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import Foundation
import RxSwift

protocol GetVideoUseCase {
  func execute(idMovie: Int) -> Observable<[Video]>
}

class DefaultGetVideoUseCase: GetVideoUseCase {
  private let repository: DetailRepository

  required init(repository: DetailRepository) {
    self.repository = repository
  }

  func execute(idMovie: Int) -> Observable<[Video]> {
    return repository.getMovieTrailer(idMovie: idMovie)
  }
}
