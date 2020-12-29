//
//  NetworkManager.swift
//  AppDevelopExample
//
//  Created by 王立 on 2020/10/20.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation
import Alamofire
import Moya

struct NetworkManager {
    func request() {
        let config = URLSessionConfiguration.default
        let session = Session.init(configuration: config)
        MoyaProvider<KKK>.init(session: session, plugins: [])
        
    }
}

struct KKK :TargetType {
    var baseURL: URL{
        return URL(string: "")!
    }
    
    var path: String{
        return ""
    }
    
    var method: Moya.Method{
        return.post
    }
    
    var sampleData: Data{
        return Data()
    }
    
    var task: Task{
        return .requestPlain
    }
    
    var headers: [String : String]?{
        nil
    }
    
    
}
