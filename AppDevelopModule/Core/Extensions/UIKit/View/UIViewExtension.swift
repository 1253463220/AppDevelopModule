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
@objc public extension UIView {
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

//圆角
@objc extension UIView{
    ///指定位置的圆角
    public func clipLayerRadius(radius:CGFloat,corner:UIRectCorner){
        self.superview?.layoutIfNeeded()
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    
}


@objc extension UIScrollView {
    /// 截长屏Image
    @objc public var captureLongImage: UIImage? {
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

@objc extension UIView {
    /// 截长屏Image
    public var captureImage: UIImage? {
        var image: UIImage? = nil
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

@objc public enum WLGradientColorDirection : Int{
    case leftright = 0
    case topdown = 1
}

// 给视图添加渐变色layer
public extension UIView {
    ///加渐变色背景
    public func addGradientColorLayer(startColor:UIColor,endColor:UIColor,direction:WLGradientColorDirection, colorSize:CGSize){
        let layer = CAGradientLayer()
        layer.frame = CGRect.init(x: 0, y: 0, width: colorSize.width, height: colorSize.height)
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
}

//scale动画
@objc public extension UIView{
    ///scales:缩放比例数组
    @objc public func addBounceAnnimation(scales:[Double] = [0.05,1.1,0.9,1],duration:Double = 0.3) {
        let animation = CAKeyframeAnimation.init(keyPath:"transform.scale")
        animation.values = scales
        animation.duration = duration
        var functions = [CAMediaTimingFunction]()
        for _ in scales {
            let function = CAMediaTimingFunction.init(name: .easeInEaseOut)
            functions.append(function)
        }
        animation.timingFunctions = functions
        animation.isRemovedOnCompletion = false
        self.layer.add(animation, forKey: "bounce")
    }
    
    ///弹跳动画
    @objc public func addJumpAnnimation() {
        let positions = [self.center,
                         .init(x: self.center.x, y: self.center.y-self.frame.size.height*2/5),
                         self.center]
        let animation = CAKeyframeAnimation.init(keyPath:"position")
        animation.values = positions
        animation.duration = 0.5
        var functions = [CAMediaTimingFunction]()
        for _ in positions {
            let function = CAMediaTimingFunction.init(name: .easeOut)
            functions.append(function)
        }
        animation.timingFunctions = functions
        animation.isRemovedOnCompletion = false
        self.layer.add(animation, forKey: "position")
    }
}

//Loading
fileprivate var loadingKey = "loadingKey"
@objc public extension UIView {
    @objc public func showLoading(color:UIColor){
        let loadingView = objc_getAssociatedObject(self, &loadingKey) as? UIActivityIndicatorView
        if loadingView == nil {
            let loadingV = UIActivityIndicatorView.init(style: .white)
            objc_setAssociatedObject(self, &loadingKey, loadingV, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.addSubview(loadingV)
            loadingV.color = color
            loadingV.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                loadingV.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                loadingV.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            loadingV.startAnimating()
        }else{
            loadingView?.startAnimating()
        }
    }
    
    @objc public func hideLoading(){
        let loadingView = objc_getAssociatedObject(self, &loadingKey) as? UIActivityIndicatorView
        if loadingView != nil {
            loadingView!.stopAnimating()
        }
    }
}

public extension UIScrollView{
    public func scroToBottom(){
        if self.contentSize.height > self.frame.height {
            self.setContentOffset(CGPoint.init(x: 0, y: self.contentSize.height-self.frame.height), animated: true)
        }else{
            self.setContentOffset(CGPoint.zero, animated: true)
        }
    }
}
