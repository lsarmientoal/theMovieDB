//
//  Configurator.swift
//  MerqueoTest
//
//  Created by Laura Sarmiento on 3/3/19.
//  Copyright © 2019 Laura Sarmiento. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import RxSwift
import RxCocoa
import Differentiator

struct Configuration: ReactiveCompatible {

    private let disposeBag = DisposeBag()
    static let shared = Configuration()
    private let httpService = Api.httpServices
    private let localStorage = Api.localStorage
    fileprivate let movie = BehaviorRelay<TheMovieDBConfiguration?>(value: nil)
    
    private init() {}
    
    func loadMovieConfiguration() {
        
        httpService.requestObject(target: TheMovieDBTarget.configuration, type: TheMovieDBConfiguration.self)
            .subscribe(onNext: { (configuration: TheMovieDBConfiguration) in
                self.movie.accept(configuration)
                self.localStorage.save(object: configuration)
            })
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base == Configuration {
    
    var movie: Observable<TheMovieDBConfiguration> {
        return base.movie.asObservable()
            .filter { $0 != nil }
            .map { $0! }
    }
}

class TheMovieDBConfiguration: Object, Mappable, IdentifiableType {
    
    @objc dynamic var images: Images?
    @objc dynamic private(set) var identity: Int = 1.hashValue
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "identity"
    }
    
    func mapping(map: Map) {
        images <- map["images"]
    }
}

class Images: Object, Mappable {
    
    @objc dynamic var baseUrl: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        baseUrl <- map["secure_base_url"]
    }
}
