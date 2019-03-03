//
//  MovieRouter.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation

protocol MovieRouterType: BaseRouterType {
    
}

class MovieRouter: MovieRouterType {
    
    static func createModule<ViewType: BaseViewController>() -> ViewType {
        
        let viewController = MovieListViewController()
        let interactor: MovieInteractorType = MovieInteractor()
        let presenter: MoviePresenterToInteractor & MoviePresenterToView = MoviePresenter()
        let router: MovieRouterType = MovieRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        
        return viewController as! ViewType
    }
}
