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
