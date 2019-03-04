//
//  MovieDetailPresenter.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import XCDYouTubeKit
import AVKit

protocol MovieDetailPresenterToView: class {
    
    var view: MovieDetailViewType! { get set }
    var router: MovieDetailRouterType! { get set }
    var interactor: MovieDetailInteractorType! { get set }
    
    func loadMovieDetail()
    func showYoutubeVideo(key: String)
}

protocol MovieDetailPresenterToInteractor: class {
    
    func showMovieDetail(_ observable: Observable<Movie>)
}

class MovieDetailPresenter: MovieDetailPresenterToView, MovieDetailPresenterToInteractor {
    
    private let disposeBag = DisposeBag()
    weak var view: MovieDetailViewType!
    var router: MovieDetailRouterType!
    var interactor: MovieDetailInteractorType!
    
    func loadMovieDetail() {
        interactor.fetchMovieDetail()
    }
    
    func showMovieDetail(_ observable: Observable<Movie>) {
        observable.subscribe(onNext: { [unowned self] (movie: Movie) in
            self.view.showMovieDatailData(movie)
        }).disposed(by: disposeBag)
    }
    
    func showYoutubeVideo(key: String) {
        let player = AVPlayerViewController()
        router.present(player)
    
        XCDYouTubeClient.default().getVideoWithIdentifier(key) { [weak player] (video: XCDYouTubeVideo?, error: Error?) in
            guard let streamURLs = video?.streamURLs else { return }
            guard let streamURL = streamURLs.values.first else { return }
            player?.player = AVPlayer(url: streamURL)
            player?.player?.play()
        }
    }
}
