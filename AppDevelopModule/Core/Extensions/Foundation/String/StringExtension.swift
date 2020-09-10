//
//  StringExtension.swift
//  Example
//
//  Created by 王立 on 2020/9/2.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation
import UIKit

///生成沙盒路径
extension String{
    public func docDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        return  (path != nil) ? path! + "/\(self)" : ""
    }
    
    public func tempDir() -> String{
        let path = NSTemporaryDirectory()
        return path + "/\(self)"
    }
    
    public func libDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
        return  (path != nil) ? path! + "/\(self)" : ""
    }
    
    public func cacheDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        return  (path != nil) ? path! + "/\(self)" : ""
    }
}

///
extension String{
    ///汉子转拼音
    public func transformToPinYin()->String{
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return  string.replacingOccurrences(of: " ", with: "")
    }
    
    /// 用正则表达式判断是否合规
    public func isAbideRegular(_ regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    ///随机字符串
    public static func uuidStr()->String{
        return NSUUID().uuidString
    }

}

// 下标截取任意位置的便捷方法
extension String {
    
    private var length: Int {
        return self.count
    }
    
    public subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    public func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    public func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    public subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

extension String{
    ///链接中某key的值
    public func urlValueFor(key:String)->String?{
        return self.urlParameters()[key]
    }
    
    ///链接中的参数字典
    public func urlParameters()->[String:String]{
        let index = self.firstIndex(of: "?")
        if let tIndex = index{
            let trueIndex = self.index(after: tIndex)
            let str = self.substring(from: trueIndex)
            let arr = str.components(separatedBy: "&")
            var dic : [String:String] = [:]
            for tstr in arr {
                let tarr = tstr.components(separatedBy: "=")
                if tarr.count == 2{
                    dic.updateValue(tarr[1], forKey: tarr[0])
                }
            }
            return dic
        }else{
            return [:]
        }
    }
}

extension String{
    public func strWidth(fontSize: CGFloat, height: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    public func strHeight(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
}
