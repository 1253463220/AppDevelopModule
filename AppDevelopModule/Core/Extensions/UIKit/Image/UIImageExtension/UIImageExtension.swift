//
//  UIImageExtension.swift
//  Example
//
//  Created by 王立 on 2020/9/3.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation
import UIKit

public enum GradientColorDirection {
    case leftright
    case topdown
}

// 图片
extension UIImage{
    ///纯色图片
    public static func colorImage(_ color:UIColor,_ size:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let con = UIGraphicsGetCurrentContext()
        con?.addRect( CGRect(x: 0, y: 0, width: size.width, height: size.height))
        con?.setFillColor(color.cgColor)
        con?.fillPath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    ///两组颜色的渐变色
    public static func gradientColorImage(_ startColor:UIColor,_ endColor:UIColor,direction:GradientColorDirection,_ size:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let con = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let sComponents = startColor.cgColor.components ?? [0,0,0,0]
        let eComponents = endColor.cgColor.components ?? [0,0,0,0]
        let components = [sComponents[0],sComponents[1],sComponents[2],sComponents[3],
        eComponents[0],eComponents[1],eComponents[2],eComponents[3]]
        let locations:[CGFloat] = [0.0, 1.0]

        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: components, locations: locations, count: 2)
        guard gradient != nil else {return UIImage()}
        var startPoint = CGPoint(x: 0, y: 0)
        var endPoint = CGPoint(x: size.width, y: 0)
        switch direction {
        case .leftright:
            break
        default:
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 0, y: size.height)
        }
        con?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}




extension UIImage{
    
    public func addWater(image:UIImage?,text:String,imageRect:CGRect,textRect:CGRect,textAttribute:[NSAttributedString.Key:Any]) -> UIImage{
        
        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if image != nil {
            image!.draw(in: imageRect)
        }
        NSString(string: text).draw(in: textRect, withAttributes: textAttribute)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage ?? self
        
    }
    
    

}
