//
//  DatabaseError.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 10/16/21.
//

import Foundation

extension DatabaseError {
  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }
}
