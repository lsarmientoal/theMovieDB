//
//  MovieInteractor.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieInteractorType: class {

    var presenter: MoviePresenterToInteractor! { get set }
    
    func fetchMovieList()
}

class MovieInteractor: MovieInteractorType {
    
    private let disposeBag = DisposeBag()
    weak var presenter: MoviePresenterToInteractor!
    private let api = Api.httpServices
    
    func fetchMovieList() {
        let observable = api.requestObject(target: TheMovieDBTarget.movieList, type: MovieList.self)
            .map { (response: MovieList) -> [Movie] in
                response.movies
            }
        presenter.showMovieListResult(observable)
    }
}
