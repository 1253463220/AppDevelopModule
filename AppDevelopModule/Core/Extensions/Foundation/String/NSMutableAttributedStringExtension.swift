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
extension NSMutableAttributedString {
    
    fileprivate var selectRange : NSRange?{
        get{
            return objc_getAssociatedObject(self, &key) as? NSRange
        }
        set{
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func done(){}
    
    public func range(_ location:Int,_ length:Int) -> NSMutableAttributedString {
        var tLocation = location
        var tLength = length
        
        if tLocation >= self.length {tLocation = self.length-1}
        if tLocation < 0 {tLocation = 0}
        if tLength < 0 {tLength = 0}
        if (tLocation+tLength > self.length) {tLength = self.length-tLocation}
        selectRange = NSRange.init(location: tLocation, length: tLength)
        return self
    }
    
    public func rangeAll() -> NSMutableAttributedString {
        guard self.length > 0 else {return self}
        selectRange = NSRange.init(location: 0, length: self.length)
        return self
    }
    
    public func color(_ setColor:UIColor) -> NSMutableAttributedString {
        guard self.length > 0 else {return self}
        self.addAttributes([NSAttributedString.Key.foregroundColor:setColor], range: selectRange ?? NSRange.init(location: 0, length: self.length))
        return self
    }
    
    public func font(_ setFont : UIFont) -> NSMutableAttributedString{
        guard self.length > 0 else {return self}
        self.addAttributes([NSAttributedString.Key.font:setFont], range: selectRange ?? NSRange.init(location: 0, length: self.length))
        return self
    }
    
    public func underlineStyle(_ underlineStyle:NSUnderlineStyle) -> NSMutableAttributedString {
        guard self.length > 0 else {return self}
        self.addAttributes([NSAttributedString.Key.underlineStyle:underlineStyle.rawValue], range: selectRange ?? NSRange.init(location: 0, length: self.length))
        return self
    }
    
    public func underlineColor(_ underlineColor:UIColor) -> NSMutableAttributedString {
        guard self.length > 0 else {return self}
        self.addAttributes([NSAttributedString.Key.underlineColor:underlineColor], range: selectRange ?? NSRange.init(location: 0, length: self.length))
        return self
    }
    
    public func lineSpacing(_ lineSpacing:CGFloat,_ alignment:NSTextAlignment = .center) -> NSMutableAttributedString {
        guard self.length > 0 else {return self}
        let ps = NSMutableParagraphStyle()
        ps.lineSpacing = lineSpacing
        ps.alignment = .center
        self.addAttributes([NSAttributedString.Key.paragraphStyle:ps], range: selectRange ?? NSRange.init(location: 0, length: self.length))
        return self
    }

    
}
