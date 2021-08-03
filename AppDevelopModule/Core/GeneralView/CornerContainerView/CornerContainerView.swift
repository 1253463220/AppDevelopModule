//
//  CornerContainerView.swift
//  yunchaodan
//
//  Created by 王立 on 2021/7/20.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

import UIKit

@objc class CornerContainerView: UIView {
    
    enum ConerStyle {
        case top
        case bottom
    }
    
    var style : ConerStyle = .top
    var corner : CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        var corners : UIRectCorner!
        switch style {
        case .top:
            corners = UIRectCorner.init([.topLeft, .topRight])
        case .bottom:
            corners = UIRectCorner.init([.bottomLeft, .bottomRight])
        }
        let cornerSize = CGSize.init(width: corner, height: corner)
        let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corners, cornerRadii: cornerSize)
        let shape = CAShapeLayer.init()
        shape.frame = rect
        shape.path = path.cgPath
        layer.mask = shape
    }
}
