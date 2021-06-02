//
//  SearchRepository.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import RxSwift

protocol SearchRepository {
  func searchMovies(query: String) -> Observable<[Movie]>
}
