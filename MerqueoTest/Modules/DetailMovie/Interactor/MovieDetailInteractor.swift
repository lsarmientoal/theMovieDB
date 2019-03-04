//
//  MovieDetailInteractor.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieDetailInteractorType: class {
    
    var movieId: Int { get set }
    var presenter: MovieDetailPresenterToInteractor! { get set }
    
    func fetchMovieDetail()
}

class MovieDetailInteractor: MovieDetailInteractorType {
    
    private let disposeBag = DisposeBag()
    var movieId: Int = 0
    weak var presenter: MovieDetailPresenterToInteractor!
    private let httpServices = Api.httpServices
    private let localStorage = Api.localStorage
    
    func fetchMovieDetail() {
        let observable = httpServices.requestObject(
            target: TheMovieDBTarget.movieDetail(movieId: movieId),
            type: Movie.self)
            .do(onNext: { [weak self] (list: Movie) in
                self?.localStorage.save(object: list)
            })
            .catchError { [weak self] _ -> Observable<Movie> in
                guard let `self` = self else { return .never() }
                return self.localStorage.requestArray(type: Movie.self)
                    .filter { !$0.isEmpty }
                    .map { $0.first! }
            }
            .flatMap { [weak self] (movie: Movie) -> Observable<Movie> in
                guard let `self` = self else { return .never() }
                return self.httpServices.requestObject(
                    target: TheMovieDBTarget.getViedos(movieId: self.movieId),
                    type: MovieTrailersResponse.self)
                    .map { (response: MovieTrailersResponse) -> Movie in
                        movie.trailers = response.results
                        return movie
                    }
            }
        presenter.showMovieDetail(observable)
    }
    
    
}
