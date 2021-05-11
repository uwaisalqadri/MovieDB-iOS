//
//  Constants.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation


struct Constants {
    
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let apiKey = "270363a57bb9637a16bdd04f9979e433"
    static let placeHolder = "https://www.btklsby.go.id/images/placeholder/basic.png"
    static let urlImage = "https://image.tmdb.org/t/p/original"
    static let lang = "en-US"
    static let sortBy = "popularity.desc"
    static let formatFromApi = "yyyy-MM-dd"
    static let dateFormat = "dd MMM, yyyy"
    static let typeMovie = "movie"
    static let youtubeUrl = "https://www.youtube.com/embed/"
    
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case discover
        case genre
        case search
        case detail
        
        public var url: String {
            switch self {
            case .discover: return "\(Constants.baseUrl)discover/movie"
            case .genre: return "\(Constants.baseUrl)genre/movie/list"
            case .search: return "\(Constants.baseUrl)search/movie"
            case .detail: return "\(Constants.baseUrl)movie/"
            }
        }
    }
    
}
