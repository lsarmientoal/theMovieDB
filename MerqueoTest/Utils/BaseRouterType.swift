//
//  BaseRouterType.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import UIKit

protocol BaseRouterType: class {
    
    static func createModule<ViewType: BaseViewController>() -> ViewType
}

extension BaseRouterType {
    
    private var navigationController: UINavigationController? {
        return (UIApplication.shared.delegate as? AppDelegate)?
            .window?.rootViewController as? UINavigationController
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.present(viewController, animated: animated, completion: completion)
    }
}
