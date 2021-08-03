//
//  GradientColorView.swift
//  yunchaodan
//
//  Created by 王立 on 2021/7/26.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

import UIKit

@objc class GradientColorView: UIView {

    var startColor = UIColor.clear
    var endColor = UIColor.clear
    var colorDirection = WLGradientColorDirection.leftright
    @objc init(startColor:UIColor,endColor:UIColor,colorDirection:WLGradientColorDirection = .leftright) {
        super.init(frame: .zero)
        self.startColor = startColor
        self.endColor = endColor
        self.colorDirection = colorDirection
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        self.addGradientColorLayer(startColor: startColor, endColor: endColor, direction: colorDirection, colorSize: rect.size)
    }

}
