//
//  LocalStorage.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocalStorageType {
    
    func requestObject<T :Object, PrimaryType>(type: T.Type, forPrimaryKey primaryKey: PrimaryType) -> Observable<T>
    func requestArray<T :Object>(type: T.Type) -> Observable<[T]>
    func save<T: Object>(object: T)
}

class LocalStorage: LocalStorageType {
    
    func requestObject<T, PrimaryType>(type: T.Type, forPrimaryKey primaryKey: PrimaryType) -> Observable<T> where T : Object {
        return Observable<T>.create { (observer: AnyObserver<T>) -> Disposable in
            let realm = try? Realm()
            guard let object = realm?.object(ofType: T.self, forPrimaryKey: primaryKey) else {
                observer.on(.error(RxError.noElements))
                return Disposables.create()
            }
            observer.on(.next(object))
            observer.on(.completed)
            return Disposables.create()
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
        .observeOn(MainScheduler.instance)
    }
    
    func requestArray<T>(type: T.Type) -> Observable<[T]> where T : Object {
        return Observable<[T]>.create { (observer: AnyObserver<[T]>) -> Disposable in
            let realm = try? Realm()
            guard let object = realm?.objects(T.self) else {
                observer.on(.error(RxError.noElements))
                return Disposables.create()
            }
            observer.on(.next(Array(object)))
            observer.on(.completed)
            return Disposables.create()
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
    }
    
    func save<T>(object: T) where T : Object {
        let realm = try? Realm()
        try? realm?.write {
            realm?.add(object, update: true)
        }
    }
}
