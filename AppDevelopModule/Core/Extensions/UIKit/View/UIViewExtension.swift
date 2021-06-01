//
//  UIViewExtension.swift
//  Example
//
//  Created by 王立 on 2020/9/3.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation
import UIKit

fileprivate var key = "badgeLabel"
@objc extension UIView {
    ///加消息小圆点,offset以右上角顶点为中心
    public func showBadgePoint(pWidth:CGFloat = 5,offset:CGPoint = CGPoint(x: 0, y: 0),color:UIColor = UIColor.red){
        let point = CALayer()
        let width = self.frame.width
        point.frame = CGRect(x: width - (pWidth/2) + offset.x, y: -(pWidth/2) + offset.y, width: pWidth, height: pWidth)
        self.layer.addSublayer(point)
        point.backgroundColor = color.cgColor
        point.cornerRadius = pWidth/2
        point.masksToBounds = true
    }
    
    //右上角文字badge
    public func showBadgeText(text:String,tWidth:CGFloat = 20,tHeight:CGFloat = 10,offset:CGPoint = CGPoint(x: 0, y: 0),config: (UILabel)->Void){
        var label = objc_getAssociatedObject(self, &key) as? UILabel
        if label == nil {
            label = UILabel()
            objc_setAssociatedObject(self, &key, label, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        let width = self.frame.width
        label!.frame = CGRect(x: width-(tWidth/2) + offset.x, y: -(tHeight/2) + offset.y, width: tWidth, height: tHeight)
        label!.textColor = UIColor.black;
        label!.font = UIFont.systemFont(ofSize: 10)
        label!.backgroundColor = UIColor(white: 1, alpha: 0.8)
        label!.textAlignment = .center
        label!.text = text
        label!.layer.cornerRadius = tHeight/2
        label!.layer.masksToBounds = true
        config(label!)
    }
}


extension UIScrollView {
    /// 截长屏Image
    var captureLongImage: UIImage? {
        var image: UIImage? = nil
        let savedContentOffset = contentOffset
        let savedFrame = layer.frame
        
        contentOffset = .zero
        layer.frame = CGRect(x: 0, y: 0,
                       width: contentSize.width,
                       height: contentSize.height)
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        contentOffset = savedContentOffset
        layer.frame = savedFrame
        return image
        
    }
}
