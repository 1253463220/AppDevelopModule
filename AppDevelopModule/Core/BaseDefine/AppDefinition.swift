//
//  AppDefinition.swift
//  NewEnergy
//
//  Created by 王立 on 2019/6/10.
//  Copyright © 2019 com.ssi. All rights reserved.
//

import Foundation
import UIKit

public struct VMSize {
    /// 屏幕宽度
    public static let width = UIScreen.main.bounds.size.width
    /// 屏幕高度
    public static let height = UIScreen.main.bounds.size.height
    /// 比例
    public static let wScale = (UIScreen.main.bounds.size.width/CGFloat(375))
    public static let hScale = (UIScreen.main.bounds.size.height/CGFloat(812))
    //状态栏高度
    public static let statusbarHeight = UIApplication.shared.statusBarFrame.size.height
    //navigtionbar高度
    static var topSafeAreaHeight : CGFloat{
        get{
            return statusbarHeight + 44
        }
    }
    //bottom iPhoneX后底部多出的高度
    static var bottomEmptyHeight : CGFloat{
        get{
            return statusbarHeight == 20 ? 0 : 34
        }
    }
    //tabbar+底部 高度
    static var bottomSafeAreaHeight : CGFloat{
        get{
            return bottomEmptyHeight + 49
        }
    }
}
public typealias vmsi = VMSize

public struct VMJudge {
    
    /// 手机号校验
    public static func judgePhone(with str: String) -> Bool {
        return judge(str, predicate: "1\\d{10}")
    }
    /// 邮箱校验
    public static func judgeEmail(with str: String) -> Bool {
        return judge(str, predicate: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+[.][A-Za-z]{2,}")
    }
    
    
    /// 网址校验
    public static func judgeUrl(with str: String) -> Bool {
        return judge(str, predicate: "(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]")
    }
    
    /// 是否是链接校验
    public static func judgeLink(with str: String) -> Bool {
        return judge(str, predicate: "(([hH][tT]{2}[pP]://|[hH][tT]{2}[pP][sS]://|[wW]{3}.|[wW][aA][pP].|[fF][tT][pP].|[fF][iI][lL][eE].)[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|])" + "|" +
                        "[a-zA-Z0-9][-a-zA-Z0-9]{1,62}(.[a-zA-Z0-9][-a-zA-Z0-9]{1,62})+.?[a-zA-Z][-a-zA-Z]{2,6}")
    }
    
    
    public static func judge(_ str: String, predicate: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", predicate).evaluate(with: str)
    }
}

public struct VMFunc {
    // MARK: - 延时函数
    public typealias DelayTask = (_ cancel : Bool) -> Void
    /// 延迟一定时间执行一个闭包
    ///
    /// - Parameters:
    ///   - time: 延迟时间
    ///   - task: 执行的闭包
    /// - Returns: 返回一个任务(用于取消执行)
    @discardableResult
    public func delay(_ time: TimeInterval, task: @escaping ()->()) ->  DelayTask? {
        
        func dispatch_later(block: @escaping ()->()) {
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }
        var closure: (()->Void)? = task
        var result: DelayTask?
        
        let delayedClosure: DelayTask = { cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        return result
    }

    /// 取消任务
    ///
    /// - Parameter task: 执行的任务
    public func delayCancle(_ task: DelayTask?) {
        task?(true)
    }
}

extension VMFunc{
    /// 打印日志
    public func Log<T>(_ message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
        #if DEBUG
        print("[\((fileName as NSString).lastPathComponent)][\(methodName)][第\(lineNumber)行]: \(message)")
        #endif
    }
}

