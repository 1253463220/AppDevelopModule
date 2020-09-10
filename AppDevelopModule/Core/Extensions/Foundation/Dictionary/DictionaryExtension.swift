//
//  DictionaryExtension.swift
//  Example
//
//  Created by 王立 on 2020/9/3.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation

extension Dictionary where Key == String,Value == String{
    public func reverseKeyValue()->Dictionary{
        var dic : [String:String] = [:]
        for key in keys {
            if let value = self[key]{
                dic.updateValue(key, forKey: value)
            }
        }
        return dic
    }
}
