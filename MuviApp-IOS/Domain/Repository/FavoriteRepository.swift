//
//  FavoriteRepository.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import RxSwift

protocol FavoriteRepository {
  func getFavoriteMovie() -> Observable<[Movie]>
  func removeFavoriteMovie(idMovie: Int) -> Observable<Bool>
}
