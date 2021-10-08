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
    public func toDocDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        return  (path != nil) ? path! + "/\(self)" : ""
    }
    
    public func toTempDir() -> String{
        let path = NSTemporaryDirectory()
        return path + "/\(self)"
    }
    
    public func toLibDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
        return  (path != nil) ? path! + "/\(self)" : ""
    }
    
    public func toCacheDir() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        return  (path != nil) ? path! + "/\(self)" : ""
    }
}

///生成沙盒路径
extension NSString{
    public func toDocDir() -> NSString {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        return  ((path != nil) ? path! + "/\(self as String)" : "") as NSString
    }
    
    public func toTempDir() -> NSString{
        let path = NSTemporaryDirectory()
        return (path + "/\(self as String)") as NSString
    }
    
    public func toLibDir() -> NSString {
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
        return  ((path != nil) ? path! + "/\(self as String)" : "") as NSString
    }
    
    public func toCacheDir() -> NSString {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        return  ((path != nil) ? path! + "/\(self as String)" : "") as NSString
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
        guard let url = URL(string: self) else {
            return [:]
        }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else {
            return [:]
        }
        var items: [String: String] = [:]
        for queryItem in queryItems {
            items[queryItem.name] = queryItem.value
        }
        return items
    }
}

extension String{
    public func width(fontSize: CGFloat, height: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.width
    }
    
    public func height(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.height
    }
}

extension String{
    func isEmptyWipeSpace()->Bool{
        let str = self.replacingOccurrences(of: " ", with: "")
        return str.isEmpty
    }
}

public extension Character {

    /// SwifterSwift: Check if character is emoji.
    ///
    ///        Character("😀").isEmoji -> true
    ///
    var isEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        let scalarValue = String(self).unicodeScalars.first!.value
        switch scalarValue {
        case 0x1F600...0x1F64F, // Emoticons
        0x1F300...0x1F5FF, // Misc Symbols and Pictographs
        0x1F680...0x1F6FF, // Transport and Map
        0x1F1E6...0x1F1FF, // Regional country flags
        0x2600...0x26FF, // Misc symbols
        0x2700...0x27BF, // Dingbats
        0xE0020...0xE007F, // Tags
        0xFE00...0xFE0F, // Variation Selectors
        0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
        127000...127600, // Various asian characters
        65024...65039, // Variation selector
        9100...9300, // Misc items
        8400...8447: // Combining Diacritical Marks for Symbols
            return true
        default:
            return false
        }
    }

    /// SwifterSwift: Integer from character (if applicable).
    ///
    ///        Character("1").int -> 1
    ///        Character("A").int -> nil
    ///
    var int: Int? {
        return Int(String(self))
    }

    /// SwifterSwift: String from character.
    ///
    ///        Character("a").string -> "a"
    ///
    var string: String {
        return String(self)
    }

    /// SwifterSwift: Return the character lowercased.
    ///
    ///        Character("A").lowercased -> Character("a")
    ///
    var lowercased: Character {
        return String(self).lowercased().first!
    }

    /// SwifterSwift: Return the character uppercased.
    ///
    ///        Character("a").uppercased -> Character("A")
    ///
    var uppercased: Character {
        return String(self).uppercased().first!
    }

}
