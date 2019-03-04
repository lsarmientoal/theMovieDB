//
//  MovieDetailViewController.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol MovieDetailViewType: class {
    
    var presenter: MovieDetailPresenterToView! { get set }
    
    func showMovieDatailData(_ movie: Movie)
}

class MovieDetailViewController: BaseViewController {

    @IBOutlet fileprivate weak var coverImageView: UIImageView!
    @IBOutlet fileprivate weak var movieTitleLabel: UILabel!
    @IBOutlet fileprivate weak var averageLabel: UILabel!
    @IBOutlet fileprivate weak var synopsisLabel: UILabel!
    @IBOutlet private weak var trailerButton: UIButton! {
        didSet {
            trailerButton.layer.masksToBounds = true
            trailerButton.layer.cornerRadius = 4.0
            trailerButton.rx.tap
                .subscribe(onNext: { [unowned self] in
                    guard let key = self.movie.trailers.first?.key else { return }
                    self.presenter.showYoutubeVideo(key: key)
                })
                .disposed(by: disposeBag)
        }
    }
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate var movie: Movie!
    var presenter: MovieDetailPresenterToView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadMovieDetail()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension MovieDetailViewController: MovieDetailViewType {
    
    func showMovieDatailData(_ movie: Movie) {
        self.movie = movie
        movieTitleLabel.text = movie.title
        synopsisLabel.text = movie.overview
        averageLabel.text = "\(Int(movie.voteAverage * 10.0)) %"
        trailerButton.isHidden = movie.trailers.first?.key == nil
        movie.rx.coverImage
            .subscribe(onNext: { [weak self] (url: URL) in
                self?.coverImageView.kf.setImage(with: url)
            })
            .disposed(by: disposeBag)
    }
}
