//
//  Cast.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 05/10/21.
//

import Foundation

protocol Credits {
  var id: Int? { get }
  var cast: [Credit]? { get }
}

protocol Credit {
  var adult: Bool? { get }
  var castId: Int? { get }
  var character: String? { get }
  var creditId: String? { get }
  var gender: Int? { get }
  var id: Int? { get }
  var knownForDepartment: String? { get }
  var name: String? { get }
  var order: Int? { get }
  var originalName: String? { get }
  var popularity: Double? { get }
  var profilePath: String? { get }
}
