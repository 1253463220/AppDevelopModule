//
//  NumberExtension.swift
//  Example
//
//  Created by 王立 on 2020/9/3.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation

extension Int{
    public init(_ str:String) {
        self.init(Double(str) ?? 0.0)
    }
}

extension String {
    ///精确到num,转换为String,注意为0.0的时候会转换成"0",小数点后为0会去掉
    public func preciseTo(_ num:Int,handleZero:Bool=true) -> String? {
        guard let value = Double(self) else { return nil }
        return value.preciseToStr(num, handleZero: handleZero)
    }
}

extension Double{
    ///精确到num
    public func preciseTo(_ num:Int) -> Double {
        var str = "."
        for _ in 0..<num {
            str += "#"
        }
        let formatter = NumberFormatter.init()
        formatter.positiveFormat = "#"+((str == ".") ? "" : str)
        let resultStr = formatter.string(from: NSNumber.init(value: self)) ?? ""
        let result = formatter.number(from: resultStr)?.doubleValue ?? 0
        return result
    }
    
    ///精确到num,转换为String。handleZero为true时，注意为0.0的时候会转换成"0",小数点后为0会去掉
    public func preciseToStr(_ num:Int,handleZero:Bool=false) -> String {
        if handleZero {
            var str = "."
            for _ in 0..<num {
                str += "#"
            }
            let formatter = NumberFormatter.init()
            formatter.positiveFormat = "#"+((str == ".") ? "" : str)
            return formatter.string(from: NSNumber.init(value: self)) ?? ""
        }else{
            return String.init(format: "%.\(num)f", self.preciseTo(num))
        }
    }
}

extension Float{
    ///精确到num
    public func preciseTo(_ num:Int) -> Float {
        var str = "."
        for _ in 0..<num {
            str += "#"
        }
        let formatter = NumberFormatter.init()
        formatter.positiveFormat = "#"+((str == ".") ? "" : str)
        let resultStr = formatter.string(from: NSNumber.init(value: self)) ?? ""
        let result = formatter.number(from: resultStr)?.floatValue ?? 0
        return result
    }
    
    ///精确到num,转换为String,注意为0.0的时候会转换成"0",小数点后为0会去掉
    public func preciseToStr(_ num:Int,handleZero:Bool=false) -> String {
        
        if handleZero {
            var str = "."
            for _ in 0..<num {
                str += "#"
            }
            let formatter = NumberFormatter.init()
            formatter.positiveFormat = "#"+str
            return formatter.string(from: NSNumber.init(value: self)) ?? ""
        }else{
            return String.init(format: "%.\(num)f", self.preciseTo(num))
        }
    }
    
}
