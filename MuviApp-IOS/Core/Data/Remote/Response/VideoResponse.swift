//
//  VideoResponse.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation


struct VideoResponse: Decodable {
    let id: Int
    let results: [VideoItem]
}

struct VideoItem: Decodable {
    let id: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
}
