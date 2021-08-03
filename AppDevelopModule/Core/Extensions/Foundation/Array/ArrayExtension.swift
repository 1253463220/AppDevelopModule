//
//  ArrayExtension.swift
//  AppDevelopExample
//
//  Created by 王立 on 2021/6/21.
//  Copyright © 2021 王立. All rights reserved.
//

import Foundation

//MARK: - 数组去重
extension Array {
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}

//MARK: - 数组前n个元素
extension Array {
    func pre(_ n : Int) -> [Element] {
        if count < n {
            return self
        }
        let seq = self[..<index(startIndex, offsetBy: n)]
        return [Element].init(seq)
    }
}
