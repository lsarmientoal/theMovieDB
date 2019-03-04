//
//  MovieDataSource.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

typealias MovieSection = AnimatableSectionModel<Int, Movie>

class MovieDataSource: RxCollectionViewSectionedAnimatedDataSource<MovieSection>, UICollectionViewDelegateFlowLayout {
    
    private let cellSpacing: CGFloat = 16.0
    private let sectionInset = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    private let disposeBag = DisposeBag()
    let movies = BehaviorRelay<[Movie]>(value: [])
    fileprivate let selectedMovie = PublishRelay<Movie>()
    
    func configure(withCollectionView collectionView: UICollectionView) {
        collectionView.register(R.nib.movieCollectionViewCell)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInset = sectionInset
            flowLayout.minimumLineSpacing = sectionInset.bottom
            flowLayout.minimumInteritemSpacing = cellSpacing
            flowLayout.scrollDirection = .vertical
        }
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        movies.asObservable()
            .map { [MovieSection(model: 1, items: $0)] }
            .bind(to: collectionView.rx.items(dataSource: self))
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Movie.self)
            .bind(to: selectedMovie)
            .disposed(by: disposeBag)
        
    }
    
    init() {
        super.init(
            configureCell: {
                (dataSource: CollectionViewSectionedDataSource<MovieSection>, collectionView: UICollectionView, indexPath: IndexPath, movie: Movie) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: R.reuseIdentifier.movieCollectionViewCell,
                    for: indexPath
                )!
                cell.configure(withMovie: movie)
                return cell
            }
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = collectionView.bounds.size
        size.width = (size.width - (sectionInset.left + sectionInset.right + cellSpacing)) / 2.0
        size.height = 280.0
        return size
    }
}

extension Reactive where Base: MovieDataSource {
    
    var selectedMovie: Observable<Movie> {
        return base.selectedMovie.asObservable()
    }
}
