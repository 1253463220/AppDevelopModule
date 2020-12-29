//
//  UIViewExtension.swift
//  Example
//
//  Created by 王立 on 2020/9/3.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation
import UIKit

// 给视图添加边框
extension UIView {
    ///加渐变色背景
    public func addGradientColorLayer(startColor:UIColor,endColor:UIColor,direction:GradientColorDirection){
        let layer = CAGradientLayer()
        layer.colors = [startColor.cgColor,endColor.cgColor]
        layer.locations = [0,1]
        switch direction {
        case .leftright:
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 1, y: 0)
        case .topdown:
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
        self.layer.insertSublayer(layer, at: 0)
    }
    
    public func removeGradientColorLayer(){
        if self.layer.sublayers != nil{
            for layer in self.layer.sublayers! {
                if layer is CAGradientLayer{
                    layer.removeFromSuperlayer()
                    break
                }
            }
        }
    }
    
    ///加消息小圆点,offset以右上角顶点为中心
    public func showSmallMessagePoint(pWidth:CGFloat = 5,offset:CGPoint = CGPoint(x: 0, y: 0),color:UIColor = UIColor.red){
        let point = CALayer()
        let width = self.frame.width
        point.frame = CGRect(x: width - (pWidth/2) + offset.x, y: -(pWidth/2) + offset.y, width: pWidth, height: pWidth)
        self.layer.addSublayer(point)
        point.backgroundColor = color.cgColor
        point.cornerRadius = pWidth/2
        point.masksToBounds = true
    }
    
}
