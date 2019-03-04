//
//  MovieList.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import Differentiator

class MovieList: Object, Mappable, IdentifiableType {
    
    var movies = List<Movie>()
    @objc dynamic var identity: Int = 1.hashValue
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "identity"
    }
    
    func mapping(map: Map) {
        movies <- (map["results"], ListTransform<Movie>())
    }
}
