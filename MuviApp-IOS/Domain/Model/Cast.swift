//
//  Cast.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation

struct Cast: Identifiable {
    let adult: Bool
    let cast_id: Int
    let character: String
    let credit_id: String
    let gender: Int
    let id: Int
    let known_for_department: String?
    let name: String
    let order: Int
    let original_name: String
    let popularity: Double
    let profile_path: String
}
