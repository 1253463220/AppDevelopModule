//
//  UIAlertController+ShowAlert.swift
//  DFVehicleSteward
//
//  Created by 王立 on 2018/3/30.
//  Copyright © 2018年 ssi. All rights reserved.
//

import Foundation
import UIKit

struct AlertUIConfig {
    var titleColor : UIColor?
    var meesageColor : UIColor?
    
}

extension UIAlertController {
    
    ///弹出多选项alert
    static func showAlert(title:String?=nil, message: String?=nil, in viewController: UIViewController?=UIApplication.shared.keyWindow?.rootViewController,options:[String],
                          endSelect: @escaping((String)->Void)){
        var avc = viewController
        if avc == nil{
            avc = UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for str in options {
            let act = UIAlertAction(title: str, style: UIAlertAction.Style.default) { (act) in
                endSelect(str)
            }
            alert.addAction(act)
        }
        avc!.present(alert, animated: true)
    }
    
    
    ///弹出选项卡actionSheet
    static func showActionSheet(title:String?=nil, message: String?=nil, in viewController: UIViewController?=UIApplication.shared.keyWindow?.rootViewController,options:[String],isShowCancel:Bool=true,cancelTitle:String="取消",
                                endSelect: @escaping((String)->Void)) {
        var avc = viewController
        if avc == nil{
            avc = UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for str in options {
            let act = UIAlertAction(title: str, style: UIAlertAction.Style.default) { (act) in
                endSelect(str)
            }
            alert.addAction(act)
        }
        if isShowCancel{
            let cancelAct = UIAlertAction(title: cancelTitle, style: .cancel) { (act) in
                endSelect(cancelTitle)
            }
            alert.addAction(cancelAct)
        }
        avc!.present(alert, animated: true)
    }
    
}
