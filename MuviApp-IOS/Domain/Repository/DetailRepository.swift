//
//  DetailRepository.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import RxSwift

protocol DetailRepository {
  func getDetailMovie(idMovie: Int) -> Observable<Movie>
  func getMovieCast(idMovie: Int) -> Observable<[Cast]>
  func getMovieTrailer(idMovie: Int) -> Observable<[Video]>
  func getFavoriteMovie() -> Observable<[Movie]>
  func addFavoriteMovie(from movie: Movie) -> Observable<Bool>
  func removeFavoriteMovie(idMovie: Int) -> Observable<Bool>
}
