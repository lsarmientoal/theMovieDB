//
//  MovieList.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import ObjectMapper

struct MovieList: Mappable {
    
    var movies: [Movie] = []
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        movies <- map["results"]
    }
}
