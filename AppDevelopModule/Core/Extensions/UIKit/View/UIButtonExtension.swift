//
//  UIButtonExtension.swift
//  Example
//
//  Created by 王立 on 2020/9/3.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    public enum ImageTitlePostion {
        case imageUpTitleDown
        case imageDownTitleUp
        case imageLeftTitleRight
        case imageRightTitleLeft
    }
    
    
    public func layout(style:ImageTitlePostion,space:CGFloat) {
        let imageSize = self.imageView?.intrinsicContentSize ?? CGSize.zero
        let labelSize = self.imageView?.intrinsicContentSize ?? CGSize.zero
        var imageTop,imageBottom,imageLeft,imageRight : CGFloat
        var titleTop,titleBottom,titleLeft,titleRight : CGFloat
        switch style {
        case .imageUpTitleDown:
            imageTop = -(labelSize.height/2+space/2)
            imageBottom = (labelSize.height/2+space/2)
            imageLeft = labelSize.width/2
            imageRight = -labelSize.width/2
            
            titleTop = imageSize.height/2+space/2
            titleBottom = -(imageSize.height/2+space/2)
            titleLeft = -imageSize.width/2
            titleRight = imageSize.width/2
        case .imageDownTitleUp:
            imageTop = (labelSize.height/2+space/2)
            imageBottom = -(labelSize.height/2+space/2)
            imageLeft = -labelSize.width/2
            imageRight = labelSize.width/2
            
            titleTop = -imageSize.height/2+space/2
            titleBottom = (imageSize.height/2+space/2)
            titleLeft = imageSize.width/2
            titleRight = -imageSize.width/2
        case .imageLeftTitleRight:
            imageTop = 0
            imageBottom = 0
            imageLeft = -space/2
            imageRight = space/2
            
            titleTop = 0
            titleBottom = 0
            titleLeft = space/2
            titleRight = -space/2
        case .imageRightTitleLeft:
            imageTop = 0;
            imageBottom = 0;
            imageLeft = labelSize.width + space / 2.0;
            imageRight = -(labelSize.width + space / 2.0);
            
            titleTop = 0;
            titleBottom = 0;
            titleLeft = -(imageSize.width + space / 2.0);
            titleRight = imageSize.width + space / 2.0;
        }
        self.imageEdgeInsets = UIEdgeInsets(top: imageTop, left: imageLeft, bottom: imageBottom, right: imageRight)
        self.titleEdgeInsets = UIEdgeInsets(top: titleTop, left: titleLeft, bottom: titleBottom, right: titleRight)
    }
    
    
    ///改变内容在x轴方向上偏移
    public func changeXOffset(_ xOffset:CGFloat){
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: xOffset, bottom: 0, right: -xOffset)
    }
    
    ///改变内容在y轴方向上偏移
    public func changeYOffset(_ yOffset:CGFloat) {
        self.contentEdgeInsets = UIEdgeInsets(top: yOffset, left: 0, bottom: -yOffset, right: 0)
    }
    
    ///改变图片文字j间距
    public func changeImageTitleDistance(distance:CGFloat) {
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -distance/2, bottom: 0, right: distance/2)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: distance/2, bottom: 0, right: distance/2)
    }
    
}
