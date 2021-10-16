//
//  LocalDataSource.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 23/08/21.
//

import RxSwift
import RealmSwift

protocol LocalDataSource {
  func getFavoriteMovie() -> Observable<[Movie]>
  func addFavoriteMovie(from movie: Movie) -> Observable<Bool>
  func removeFavoriteMovie(idMovie: Int) -> Observable<Bool>
}
