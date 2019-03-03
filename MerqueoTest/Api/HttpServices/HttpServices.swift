//
//  HttpServices.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import Moya_ObjectMapper
import ObjectMapper

protocol HttpServicesType {
    
    func requestObject<Target: TargetType, Object: Mappable>(target: Target, type: Object.Type) -> Observable<Object>
    func requestArray<Target: TargetType, Object: Mappable>(target: Target, type: Object.Type) -> Observable<[Object]>
}

class HttpServices: HttpServicesType {
    
    var retainProvier: Any?
    
    private func request<T: TargetType>(target: T) -> Single<Response> {
        let provider = MoyaProvider<T>()
        retainProvier = provider
        return provider.rx.request(target)
    }
    
    func requestObject<Target, Object>(target: Target, type: Object.Type) -> Observable<Object> where Target : TargetType, Object : Mappable {
        return request(target: target)
            .asObservable()
            .mapObject(Object.self)
    }
    
    func requestArray<Target, Object>(target: Target, type: Object.Type) -> Observable<[Object]> where Target : TargetType, Object : Mappable {
        return request(target: target)
            .asObservable()
            .mapArray(Object.self)
    }
}
