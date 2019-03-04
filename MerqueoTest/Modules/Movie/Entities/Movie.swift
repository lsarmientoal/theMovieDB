//
//  Movie.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import ObjectMapper
import Differentiator
import RealmSwift
import RxSwift

class Movie: Object, Mappable, IdentifiableType {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var coverPath: String = ""
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var overview: String = ""
    var trailers = List<MovieTrailer>()
    
    var identity: Int {
        return id.hashValue
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }

    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        posterPath <- map["poster_path"]
        coverPath <- map["backdrop_path"]
        voteAverage <- map["vote_average"]
        overview <- map["overview"]
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.identity == rhs.identity
    }
}

extension Reactive where Base: Movie {
    
    var posterImage: Observable<URL> {
        return Configuration.shared.rx.movie
            .flatMap { (configuration: TheMovieDBConfiguration) -> Observable<URL> in
                guard let baseUrl = configuration.images?.baseUrl else { return Observable<URL>.never() }
                guard let url = URL(string: baseUrl + "w780" + self.base.posterPath) else { return Observable<URL>.never() }
                return Observable<URL>.just(url)
            }
    }
    
    var coverImage: Observable<URL> {
        return Configuration.shared.rx.movie
            .flatMap { (configuration: TheMovieDBConfiguration) -> Observable<URL> in
                guard let baseUrl = configuration.images?.baseUrl else { return Observable<URL>.never() }
                guard let url = URL(string: baseUrl + "w780" + self.base.coverPath) else { return Observable<URL>.never() }
                return Observable<URL>.just(url)
        }
    }
}
