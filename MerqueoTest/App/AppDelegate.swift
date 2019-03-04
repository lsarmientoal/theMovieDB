//
//  AppDelegate.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = MovieRouter.createModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.view.tintColor = .white
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        Configuration.shared.loadMovieConfiguration()
        return true
    }
}

