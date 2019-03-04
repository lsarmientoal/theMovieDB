//
//  MovieTrailers.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/4/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class MovieTrailersResponse: Object, Mappable {
 
    @objc dynamic var id: String = ""
    var results = List<MovieTrailer>()
    
    required convenience init(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        results <- (map["results"], ListTransform<MovieTrailer>())
    }
}

class MovieTrailer: Object, Mappable {
    
    @objc dynamic var id: String = ""
    @objc dynamic var key: String = ""
    @objc dynamic var name: String = ""
    
    required convenience init(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }

    func mapping(map: Map) {
        id <- map["id"]
        key <- map["key"]
        name <- map["name"]
    }
}
