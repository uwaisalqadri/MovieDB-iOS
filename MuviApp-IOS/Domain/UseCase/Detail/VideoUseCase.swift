//
//  VideoUseCase.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 05/10/21.
//

import RxSwift

protocol VideoUseCase {
  func execute(param: DetailParameter) -> Observable<[Video]>
}

class VideoInteractor: VideoUseCase {
  private let repository: MovieRepository

  init(repository: MovieRepository) {
    self.repository = repository
  }

  func execute(param: DetailParameter) -> Observable<[Video]> {
    return repository.getVideo(detailParam: param)
  }
}
