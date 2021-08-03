//
//  UIButtonExtension.swift
//  Example
//
//  Created by 王立 on 2020/9/3.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation
import UIKit

@objc public enum ImageTitlePostion : Int{
    case imageUpTitleDown
    case imageDownTitleUp
    case imageLeftTitleRight
    case imageRightTitleLeft
}
fileprivate var imageTitlePositionKey = "imageTitlePositionKey"
fileprivate var imageTitleDistanceKey = "imageTitleDistanceKey"
@objc extension UIButton{
    public func relayoutImgTitle(style:ImageTitlePostion,imgTitleSpace space:CGFloat) {
        let imageSize = self.imageView?.intrinsicContentSize ?? CGSize.zero
        let labelSize = self.titleLabel?.intrinsicContentSize ?? CGSize.zero
        var imageTop,imageBottom,imageLeft,imageRight : CGFloat
        var titleTop,titleBottom,titleLeft,titleRight : CGFloat
        switch style {
        case .imageUpTitleDown:
            imageTop = -(labelSize.height/2+space/2)
            imageBottom = (labelSize.height/2+space/2)
            imageLeft = labelSize.width/2-imageSize.width/2
            imageRight = 0
            
            titleTop = imageSize.height/2+space/2
            titleBottom = -(imageSize.height/2+space/2)
            titleLeft = -imageSize.width
            titleRight = 0
        case .imageDownTitleUp:
            imageTop = (labelSize.height/2+space/2)
            imageBottom = -(labelSize.height/2+space/2)
            imageLeft = labelSize.width/2-imageSize.width/2
            imageRight = 0
            
            titleTop = -imageSize.height/2+space/2
            titleBottom = (imageSize.height/2+space/2)
            titleLeft = -imageSize.width
            titleRight = 0
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
        objc_setAssociatedObject(self, &imageTitlePositionKey, style, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &imageTitleDistanceKey, space, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    
    ///改变内容在x轴方向上偏移
    public func changeXOffset(_ xOffset:CGFloat){
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: xOffset, bottom: 0, right: -xOffset)
    }
    
    ///改变内容在y轴方向上偏移
    public func changeYOffset(_ yOffset:CGFloat) {
        self.contentEdgeInsets = UIEdgeInsets(top: yOffset, left: 0, bottom: -yOffset, right: 0)
    }
    
    ///内容size
    public func intrinsicSize()->CGSize{
        let type = (objc_getAssociatedObject(self, &imageTitlePositionKey) as? ImageTitlePostion) ?? .imageLeftTitleRight
        let space = (objc_getAssociatedObject(self, &imageTitleDistanceKey) as? CGFloat) ?? 0
        switch type {
        case .imageLeftTitleRight,.imageRightTitleLeft:
            return CGSize.init(width: self.intrinsicContentSize.width+space, height: self.intrinsicContentSize.height)
        case .imageUpTitleDown,.imageDownTitleUp:
            let cRect = CGRect.init(x: 0, y: 0, width: self.intrinsicContentSize.width, height: self.intrinsicContentSize.height)
            let imageSize = self.imageRect(forContentRect: cRect)
            let titleSize = self.titleRect(forContentRect: cRect)
            return CGSize.init(width: max(imageSize.width, titleSize.width), height: imageSize.height+titleSize.height+space)
        }
    }
    
}
