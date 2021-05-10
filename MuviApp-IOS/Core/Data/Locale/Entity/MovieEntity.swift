//
//  MovieEntity.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import Foundation
import RealmSwift

public class MovieEntity: Object {
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdrop_path: String? = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var original_language: String = ""
    @objc dynamic var original_title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var poster_path: String? = ""
    @objc dynamic var release_date: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var video: Bool = false
    @objc dynamic var vote_average: Double = 0.0
    @objc dynamic var vote_count: Int = 0
    
    public override class func primaryKey() -> String? {
        return "id"
    }
}
