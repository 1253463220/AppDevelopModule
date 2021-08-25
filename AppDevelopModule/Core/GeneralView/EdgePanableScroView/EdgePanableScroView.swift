//
//  EdgeEnableScroView.swift
//  yunchaodan
//
//  Created by 王立 on 2021/8/18.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

import UIKit

@objc class EdgePanableScroView: UIScrollView ,UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if isEdgePan(ges: gestureRecognizer) {
            return true
        }
        return false
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if isEdgePan(ges: gestureRecognizer) {
            return false
        }
        return true
    }
    
    private func isEdgePan(ges:UIGestureRecognizer)->Bool{
        let edgeW : CGFloat = 0.15*(UIScreen.main.bounds.size.width)
        if ges == self.panGestureRecognizer {
            let panGes = ges as! UIPanGestureRecognizer
            let point = panGes.translation(in: self)
            let locationX = panGes.location(in: self).x.truncatingRemainder(dividingBy: screenw_f)
            if panGes.state == .began || panGes.state == .possible {
                if point.x > 0 && locationX < edgeW {
                    return true
                }
            }
        }
        return false
    }

}
