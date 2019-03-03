//
//  MoviePresenter.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import RxSwift

protocol MoviePresenterToView: class {
    
    var view: MovieViewType! { get set }
    var router: MovieRouterType! { get set }
    var interactor: MovieInteractorType! { get set }
    
    func loadMovieList()
}

protocol MoviePresenterToInteractor: class {
    
    func showMovieListResult(_ observable: Observable<[Movie]>)
}

class MoviePresenter: MoviePresenterToView, MoviePresenterToInteractor {
    
    weak var view: MovieViewType!
    var router: MovieRouterType!
    var interactor: MovieInteractorType!
    
    func loadMovieList() {
        interactor.fetchMovieList()
    }
    
    func showMovieListResult(_ observable: Observable<[Movie]>) {
        
    }
}
