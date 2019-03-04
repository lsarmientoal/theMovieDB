//
//  ObjectMapperTransform.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/4/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

public struct ListTransform<T: RealmSwift.Object>: TransformType where T: BaseMappable {
    
    public init() { }
    
    public typealias Object = List<T>
    public typealias JSON = Array<Any>
    
    public func transformFromJSON(_ value: Any?) -> List<T>? {
        if let objects = Mapper<T>().mapArray(JSONObject: value) {
            let list = List<T>()
            list.append(objectsIn: objects)
            return list
        }
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        return value?.compactMap { $0.toJSON() }
    }
}
