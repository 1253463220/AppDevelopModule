//
//  WindowCallOutView.swift
//  JGPT
//
//  Created by 王立 on 2018/12/26.
//  Copyright © 2018 南斗六星. All rights reserved.
//

import UIKit

@objc public class WindowCallOutView: UIView ,UIGestureRecognizerDelegate{

    var shouldTapDismiss = false
    // MARK: 生命周期
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapBackContent(ges:)))
        tap.delegate = self
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: 数据
    // MARK: 界面
    
    // MARK: 事件
    @objc private func tapBackContent(ges:UITapGestureRecognizer){
        if shouldTapDismiss{
            self.dismiss()
        }
    }
    // MARK: 逻辑
    func show() {
        var tKeyWindow : UIWindow?
        if #available(iOS 13.0, *), UIApplication.shared.windows.count > 0{
            tKeyWindow = UIApplication.shared.windows.first
        }else{
            tKeyWindow = UIApplication.shared.keyWindow
        }
        if let keyWindow = tKeyWindow{
            keyWindow.addSubview(self)
            self.topAnchor.constraint(equalTo: keyWindow.topAnchor).isActive = true
            self.leftAnchor.constraint(equalTo: keyWindow.leftAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor).isActive = true
            self.rightAnchor.constraint(equalTo: keyWindow.rightAnchor).isActive = true
            self.alpha = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 1
            }) { (isCom) in
                
            }
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { (isCom) in
            if isCom{
                self.removeFromSuperview()
            }
        }
    }
    // MARK: 代理
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if let tview = touch.view,
            NSStringFromClass(tview.classForCoder) == "UITableViewCellContentView" ||
            NSStringFromClass(tview.classForCoder) == "UITableViewCell"{
            return false
        }
        return true
    }

}
