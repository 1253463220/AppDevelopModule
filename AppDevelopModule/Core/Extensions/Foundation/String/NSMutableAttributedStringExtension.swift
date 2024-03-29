//
//  NSMutableAttributedStringExtension.swift
//  Example
//
//  Created by 王立 on 2020/9/3.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation
import UIKit

fileprivate var key = "selectRange"
@objc extension NSMutableAttributedString {
    
    public func done(){}
    
    public func range(_ location:Int,_ length:Int) -> NSMutableAttributedString {
        var tLocation = location
        var tLength = length
        
        if tLocation >= self.length {tLocation = self.length-1}
        if tLocation < 0 {tLocation = 0}
        if tLength < 0 {tLength = 0}
        if (tLocation+tLength > self.length) {tLength = self.length-tLocation}
        let range = NSRange.init(location: tLocation, length: tLength)
        objc_setAssociatedObject(self, &key, range, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return self
    }
    
    public func rangeAll() -> NSMutableAttributedString {
        guard self.length > 0 else {return self}
        let range = NSRange.init(location: 0, length: self.length)
        objc_setAssociatedObject(self, &key, range, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return self
    }
    
    public func color(_ setColor:UIColor) -> NSMutableAttributedString {
        guard self.length > 0 else {return self}
        let selectRange = (objc_getAssociatedObject(self, &key) ?? NSRange(location: 0, length: self.length)) as! NSRange
        self.addAttributes([NSAttributedString.Key.foregroundColor:setColor], range: selectRange)
        return self
    }
    
    public func font(_ setFont : UIFont) -> NSMutableAttributedString{
        guard self.length > 0 else {return self}
        let selectRange = (objc_getAssociatedObject(self, &key) ?? NSRange(location: 0, length: self.length)) as! NSRange
        self.addAttributes([NSAttributedString.Key.font:setFont], range: selectRange)
        return self
    }
    
    public func underlineStyle(_ underlineStyle:NSUnderlineStyle) -> NSMutableAttributedString {
        guard self.length > 0 else {return self}
        let selectRange = (objc_getAssociatedObject(self, &key) ?? NSRange(location: 0, length: self.length)) as! NSRange
        self.addAttributes([NSAttributedString.Key.underlineStyle:underlineStyle.rawValue], range: selectRange)
        return self
    }
    
    public func underlineColor(_ underlineColor:UIColor) -> NSMutableAttributedString {
        guard self.length > 0 else {return self}
        let selectRange = (objc_getAssociatedObject(self, &key) ?? NSRange(location: 0, length: self.length)) as! NSRange
        self.addAttributes([NSAttributedString.Key.underlineColor:underlineColor], range: selectRange)
        return self
    }
    
    public func lineSpacing(_ lineSpacing:CGFloat,_ alignment:NSTextAlignment = .center) -> NSMutableAttributedString {
        guard self.length > 0 else {return self}
        let ps = NSMutableParagraphStyle()
        ps.lineSpacing = lineSpacing
        ps.alignment = .center
        let selectRange = (objc_getAssociatedObject(self, &key) ?? NSRange(location: 0, length: self.length)) as! NSRange
        self.addAttributes([NSAttributedString.Key.paragraphStyle:ps], range: selectRange)
        return self
    }

    
}
