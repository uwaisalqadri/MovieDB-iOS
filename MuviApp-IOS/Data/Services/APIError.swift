//
//  APIError.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation

extension ApiError {
  var localizedDescription: String {
    switch self {
    case .unknown:
      return "An error occurred. Please try again later."
    case .connectionError:
      return "Connection problem. Please check your internet connection."
    case .invalidJSONError:
      return "Service response in an unexpected format."
    case .middlewareError(_, let message):
      return message ?? ""
    case .failedMappingError:
      return "Failed to read server's response."
    }
  }
}
