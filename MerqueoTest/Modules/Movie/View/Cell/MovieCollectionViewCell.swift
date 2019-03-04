//
//  MovieCollectionViewCell.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    private let disposeBag = DisposeBag()
    @IBOutlet private weak var titleLbel: UILabel!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var progressLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.layer.masksToBounds = true
            posterImageView.layer.cornerRadius = 8.0
        }
    }

    func configure(withMovie movie: Movie) {
        titleLbel.text = movie.title
        let progress: Float = Float(movie.voteAverage) / 10.0
        progressView.setProgress(progress, animated: true)
        progressLabel.text = "\(Int(progress * 100.0))%"
        movie.rx.posterImage
            .subscribe(onNext: { [weak self] (imageUrl: URL) in
                self?.posterImageView.kf.setImage(with: imageUrl)
            })
            .disposed(by: disposeBag)
    }
}
