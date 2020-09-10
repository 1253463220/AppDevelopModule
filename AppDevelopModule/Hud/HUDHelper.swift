//
//  HUDHelper.swift
//  DFVehicleSteward
//
//  Created by 王立 on 2018/3/29.
//  Copyright © 2018年 ssi. All rights reserved.
//

import Foundation
import SVProgressHUD
import MBProgressHUD

struct HUDHelper {
    
    static func show(status: String = "") {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultStyle(.dark)
        if status.isEmpty {
            SVProgressHUD.show()
        } else {
            SVProgressHUD.show(withStatus: status)
        }
    }
    
    static func showBackNone(status: String = ""){
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setDefaultStyle(.dark)
        if status.isEmpty {
            SVProgressHUD.show()
        } else {
            SVProgressHUD.show(withStatus: status)
        }
    }
    
    static func showInfo(with text: String?,dismissDelay:TimeInterval=1.5) {
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.showInfo(withStatus: text)
        SVProgressHUD.dismiss(withDelay: dismissDelay)
    }
    
    
    static func showError(with text: String? = "请求失败！",dismissDelay:TimeInterval=1.5) {
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.showError(withStatus: text)
        SVProgressHUD.dismiss(withDelay: dismissDelay)
    }
    
    static func showSuccess(with text: String?,dismissDelay:TimeInterval=1.5){
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.showSuccess(withStatus: text)
        SVProgressHUD.dismiss(withDelay: dismissDelay)
    }
    
    static func dismiss() {
        SVProgressHUD.dismiss()
    }
}


extension HUDHelper{
    
    static func showMBAutoHide(onView view: UIView,text:String = "",afterDelay:Double){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = text
        hud.bezelView.backgroundColor = UIColor.black
        hud.contentColor = UIColor.white
        hud.hide(animated: true, afterDelay: afterDelay)
    }
    
    static func showMB(onView view: UIView,text:String = ""){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.bezelView.backgroundColor = UIColor.black
        hud.contentColor = UIColor.white
        hud.label.text = text
    }
    
    static func showMBThroughTouch(onView view: UIView,text:String = ""){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = text
        hud.isUserInteractionEnabled = false
        hud.bezelView.backgroundColor = UIColor.black
        hud.contentColor = UIColor.white
    }
    
    static func hideMB(forView view: UIView){
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    
}
