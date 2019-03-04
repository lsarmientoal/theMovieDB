//
//  MovieDetailRouter.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation


protocol MovieDetailRouterType: BaseRouterType {
    
}

class MovieDetailRouter: MovieDetailRouterType {
    
    static func createModule<ViewType: BaseViewController>() -> ViewType {
        
        let viewController = MovieDetailViewController()
        let interactor: MovieDetailInteractorType = MovieDetailInteractor()
        let presenter: MovieDetailPresenterToInteractor & MovieDetailPresenterToView = MovieDetailPresenter()
        let router: MovieDetailRouterType = MovieDetailRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return viewController as! ViewType
    }
}
