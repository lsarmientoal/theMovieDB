//
//  TheMovieDBTarget.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import Moya

private let apiKey = "16e1d957dc7eb0335968c3e29b6e94a9"

enum TheMovieDBTarget: TargetType {
    
    case movieList
    case movieDetail(movieId: Int)
    case movieCredit(movieId: Int)
    case configuration
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .movieList: return "/discover/movie?api_key=\(apiKey)"
        case .movieDetail(let movieId): return "/movie/\(movieId)?api_key=\(apiKey)"
        case .movieCredit(let movieId): return "/movie/\(movieId)/credits?api_key=\(apiKey)"
        case .configuration : return "/configuration?api_key=\(apiKey)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .movieList, .movieDetail, .movieCredit, .configuration:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .movieList, .movieDetail, .movieCredit, .configuration:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .movieList, .movieDetail, .movieCredit, .configuration:
            return nil
        }
    }
}
