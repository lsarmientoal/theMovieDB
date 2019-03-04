//
//  MoviePresenter.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MoviePresenterToView: class {
    
    var view: MovieViewType! { get set }
    var router: MovieRouterType! { get set }
    var interactor: MovieInteractorType! { get set }
    
    func loadMovieList()
    func configureDataSource(withCollectionView collectionView: UICollectionView)
}

protocol MoviePresenterToInteractor: class {
    
    func showMovieListResult(_ observable: Observable<MovieList>)
}

class MoviePresenter: MoviePresenterToView, MoviePresenterToInteractor {
    
    private let disposeBag = DisposeBag()
    weak var view: MovieViewType!
    var router: MovieRouterType!
    var interactor: MovieInteractorType!
    let dataSource = MovieDataSource()
    
    func loadMovieList() {
        interactor.fetchMovieList()
    }
    
    func showMovieListResult(_ observable: Observable<MovieList>) {
        observable
            .map { (response: MovieList) -> [Movie] in
                Array(response.movies)
            }
            .bind(to: dataSource.movies)
            .disposed(by: disposeBag)
        
        dataSource.rx.selectedMovie
            .subscribe(onNext: { [unowned self] (selectedMovie: Movie) in
                self.router.goToMovieDetail(selectedMovie)
            })
            .disposed(by: disposeBag)
    }
    
    func configureDataSource(withCollectionView collectionView: UICollectionView) {
        dataSource.configure(withCollectionView: collectionView)
    }
}
