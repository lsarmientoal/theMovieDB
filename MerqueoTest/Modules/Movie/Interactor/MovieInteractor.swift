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
    private let httpServices = Api.httpServices
    private let localStorage = Api.localStorage
    
    func fetchMovieList() {
        let observable = httpServices.requestObject(target: TheMovieDBTarget.movieList, type: MovieList.self)
            .do(onNext: { [weak self] (list: MovieList) in
                self?.localStorage.save(object: list)
            })
            .catchError { [weak self] _ -> Observable<MovieList> in
                guard let `self` = self else { return .never() }
                return self.localStorage.requestArray(type: MovieList.self)
                    .filter { !$0.isEmpty }
                    .map { $0.first! }
            }
        presenter.showMovieListResult(observable)
    }
}
