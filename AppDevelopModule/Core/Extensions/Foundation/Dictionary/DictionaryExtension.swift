//
//  DictionaryExtension.swift
//  Example
//
//  Created by 王立 on 2020/9/3.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation

extension Dictionary where Value : Hashable{

    public var reverseKeyValue : [Value:Key]{
        var dic : [Value:Key] = [:]
        for key in keys {
            if let value = self[key]{
                dic[value] = key
            }
        }
        return dic
    }
}
