//
//  HomeRepository.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import RxSwift

protocol HomeRepository {
  func getDiscoverMovies(year: String, page: Int) -> Observable<[Movie]>
}
