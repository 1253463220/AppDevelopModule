//
//  RXNetwork.swift
//  yunchaodan
//
//  Created by 王立 on 2021/5/31.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

import Foundation
import HandyJSON
import Alamofire

extension Response {
    
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let result = type.deserialize(from: jsonString) else { throw YXNetworkError.JsonMap  }
        return result
    }
    
    func mapArray<T: HandyJSON>(_ type: T.Type) throws -> [T] {
        guard let array = try mapJSON() as? [[String: Any]] else {
            throw YXNetworkError.JsonMap
        }
        guard let modelArr = [T].deserialize(from: array) else {
            throw YXNetworkError.JsonMap
        }
        var model_arr: [T] = []
        for model in modelArr {
            if let t_model = model {
                model_arr.append(t_model)
            }
        }
        return model_arr
    }
    
    func mapModel<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let result = type.deserialize(from: jsonString, designatedPath: keyPath) else { throw YXNetworkError.JsonMap  }
        return result
    }
    
    func mapArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) throws -> [T] {
        let arrayString = String(data: data, encoding: .utf8)
        guard let modelArr = [T].deserialize(from: arrayString, designatedPath: keyPath) else {
            throw YXNetworkError.JsonMap
        }
        var model_arr: [T] = []
        for model in modelArr {
            if let t_model = model {
                model_arr.append(t_model)
            }
        }
        return model_arr
    }
    
}


extension ObservableType where Element: Response {

    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapModel(T.self))
        }
    }
    
    
    public func mapModel<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapModel(T.self, atKeyPath: keyPath))
        }
    }
    
    func mapArray<T: HandyJSON>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(type))
        }
    }
    
    func mapArray<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(type, atKeyPath: keyPath))
        }
    }

}


extension Dictionary where Key == String,Value == Any {
    
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        guard let result = type.deserialize(from: self) else { throw YXNetworkError.JsonMap  }
        return result
    }
    
    func mapModel<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) throws -> T {
        guard let result = type.deserialize(from: self, designatedPath: keyPath) else { throw YXNetworkError.JsonMap  }
        return result
    }
    
}

extension ObservableType where Element == Dictionary<String, Any> {

    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { dic -> Observable<T> in
            return Observable.just(try dic.mapModel(T.self))
        }
    }
    
    
    public func mapModel<T: HandyJSON>(_ type: T.Type, atKeyPath keyPath: String) -> Observable<T> {
        return flatMap { dic -> Observable<T> in
            return Observable.just(try dic.mapModel(T.self, atKeyPath: keyPath))
        }
    }

}
