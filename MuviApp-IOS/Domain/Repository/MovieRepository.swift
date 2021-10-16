//
//  MovieRepository.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation
import RxSwift

protocol MovieRepository {
  func getDiscover(discoverParam: DiscoverParamater) -> Observable<[Movie]>
  func getDetail(detailParam: DetailParameter) -> Observable<Movie>
  func getSearch(searchParam: SearchParamater) -> Observable<[Movie]>
  func getVideo(detailParam: DetailParameter) -> Observable<[Video]>
  func getCredit(detailParam: DetailParameter) -> Observable<[Credit]>

  func getFavoriteMovie() -> Observable<[Movie]>
  func addFavoriteMovie(from movie: Movie)
  func removeFavoriteMovie(from movie: Movie)
}
