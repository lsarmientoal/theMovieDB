//
//  Movie.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import ObjectMapper

struct Movie: Mappable {
    
    var id: Int = 0
    var title: String = ""
    var cover: String = ""
    var voteAverage: Double = 0.0
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        cover <- map["backdrop_path"]
        voteAverage <- map["vote_average"]
    }
}
