//
//  MovieListViewController.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import UIKit

protocol MovieViewType: class {
    
    var presenter: MoviePresenterToView! { get set }
}

class MovieListViewController: BaseViewController {
    
    var presenter: MoviePresenterToView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadMovieList()
    }
}

extension MovieListViewController: MovieViewType {
    
}
