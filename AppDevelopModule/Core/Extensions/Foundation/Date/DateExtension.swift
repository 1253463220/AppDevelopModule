//
//  DateExtension.swift
//  Example
//
//  Created by 王立 on 2020/9/3.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation

extension Date{
    public func toString(_ formatter:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let format = DateFormatter()
        format.dateFormat = formatter
        return format.string(from: self)
    }
}

extension String{
    public func toDate(_ currentFormatter: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let format = DateFormatter()
        format.dateFormat = currentFormatter
        return format.date(from: self) ?? Date(timeIntervalSince1970: 0)
    }
    
    public func changeDateFormatter(_ oldFormatter:String = "yyyy-MM-dd HH:mm:ss",_ newFormatter:String) -> String {
        let currentDate = toDate(oldFormatter)
        return currentDate.toString(newFormatter)
    }
    
}

@objc extension NSDate{
    @objc public func toString(_ formatter:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let format = DateFormatter()
        format.dateFormat = formatter
        return format.string(from: self as Date)
    }
}

@objc extension NSString{
    @objc public func toDate(_ currentFormatter: String = "yyyy-MM-dd HH:mm:ss") -> NSDate {
        let format = DateFormatter()
        format.dateFormat = currentFormatter
        return (format.date(from: self as String) as? NSDate) ?? NSDate(timeIntervalSince1970: 0) as NSDate
    }
    
    @objc public func changeDateFormatter(_ oldFormatter:String = "yyyy-MM-dd HH:mm:ss",_ newFormatter:String) -> String {
        let currentDate = toDate(oldFormatter)
        return currentDate.toString(newFormatter)
    }
    
}
