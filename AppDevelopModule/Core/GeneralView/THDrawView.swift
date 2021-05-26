//
//  THDrawView.swift
//  CareInsureAssess
//
//  Created by LaresAdmin on 2021/3/17.
//

import UIKit
import Foundation
//MARK: 三次贝塞尔曲线
class THDrawView: UIView {
    private let beizer = UIBezierPath()
    private let shapelayer = CAShapeLayer()
    private var pts = [CGPoint.zero,CGPoint.zero,CGPoint.zero,CGPoint.zero,CGPoint.zero]
    private var ctr = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func clear() {
        shapelayer.path = nil
        beizer.removeAllPoints()
    }
    //判断画布是不是是空的
    func isEmpty() ->Bool {
        return self.beizer.isEmpty
    }
    
    private func commonInit() {
        shapelayer.fillColor = nil
        shapelayer.lineCap = CAShapeLayerLineCap.round
        shapelayer.lineJoin = .round
        shapelayer.strokeColor = UIColor.black.cgColor
        shapelayer.lineWidth = 5
        layer.addSublayer(shapelayer)
        shapelayer.path = beizer.cgPath
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let point = touch.location(in: self)
        beizer.move(to: point)
        ctr = 0
        pts[0] = point
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let point = touch.location(in: self)
        ctr += 1
        pts[ctr] = point
        if ctr == 4 {
            pts[3] = CGPoint(x:(pts[2].x + pts[4].x)/2.0, y:(pts[2].y + pts[4].y)/2.0)
            beizer.move(to: pts[0])
            
            beizer.addCurve(to: pts[3], controlPoint1: pts[1], controlPoint2: pts[2])
            pts[0] = pts[3]
            pts[1] = pts[4]
            ctr = 1
        }
        shapelayer.path = beizer.cgPath
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let _ = touches.first else {return}
        if ctr < 4 {
            for _ in ((ctr+1)...4).reversed() {
                self.touchesMoved(touches, with: event)
            }
        }
        ctr = 0
    }
}
