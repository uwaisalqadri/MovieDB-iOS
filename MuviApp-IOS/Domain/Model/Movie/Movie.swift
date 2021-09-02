//
//  Movie.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation

protocol Movies {
  var page: Int? { get }
  var results: [Movie]? { get }
  var totalPages: Int? { get }
  var totalResults: Int? { get }
}


protocol Movie {
  var adult: Bool? { get }
  var backdropPath: String? { get }
  var genreIDS: [Int]? { get }
  var id: Int? { get }
  var originalTitle: String? { get }
  var overview: String? { get }
  var popularity: Double? { get }
  var posterPath: String? { get }
  var releaseDate: String? { get }
  var title: String? { get }
  var video: Bool? { get }
  var voteAverage: Double? { get }
  var voteCount: Int? { get }
}
