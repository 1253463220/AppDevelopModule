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
        self.init(lround(Double(str) ?? 0.0))
    }
}

extension String {
    ///精确到num,转换为String,注意为0.0的时候会转换成"0",小数点后为0会去掉
    public func preciseTo(_ num:Int) -> String? {
        guard let value = Double(self) else { return nil }
        return value.preciseToStr(num)
    }
}

extension Double{
    ///精确到num
    public func preciseTo(_ num:Int) -> Double {
        var count : Double = 1
        for _ in 0..<num {
            count = count * 10
        }
        return Double(llround(self * count))/count
    }
    
    ///精确到num,转换为String。handleZero为true时，注意为0.0的时候会转换成"0",小数点后为0会去掉
    public func preciseToStr(_ num:Int,handleZero:Bool=true) -> String {
        if handleZero{
            return self.preciseTo(num).stringValue_custom()
        }else{
            return "\(self.preciseTo(num))"
        }
    }
    
    ///转化为字符串，注意为0.0的时候会转换成0,小数点后为0会去掉
    private func stringValue_custom()->String{
        if self == 0{
            return "0"
        }
        if self == Double(llround(self)){
            return "\(llround(self))"
        }
        return "\(self)"
    }
}

extension Float{
    ///精确到num
    public func preciseTo(_ num:Int) -> Float {
        var count : Float = 1
        for _ in 0..<num {
            count = count * 10
        }
        return Float(llroundf(self * count))/count
    }
    
    ///精确到num,转换为String,注意为0.0的时候会转换成"0",小数点后为0会去掉
    public func preciseToStr(_ num:Int) -> String {
        return self.preciseTo(num).stringValue_custom()
    }
    
    ///转化为字符串，注意为0.0的时候会转换成0,小数点后为0会去掉
    private func stringValue_custom()->String{
        if self == 0{
            return "0"
        }
        if self == Float(llroundf(self)){
            return "\(llroundf(self))"
        }
        return "\(self)"
    }
}
