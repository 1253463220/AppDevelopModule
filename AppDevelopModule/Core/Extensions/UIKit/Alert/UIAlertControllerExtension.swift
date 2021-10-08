//
//  UIAlertController+ShowAlert.swift
//  DFVehicleSteward
//
//  Created by 王立 on 2018/3/30.
//  Copyright © 2018年 ssi. All rights reserved.
//

import Foundation
import UIKit
 
@objc extension UIAlertController {
    
    ///弹出多选项alert
    static func showAlert(title:String?=nil, message: String?=nil, in viewController: UIViewController?=UIApplication.shared.keyWindow?.rootViewController,options:[[String:UIAlertAction.Style.RawValue]],
                          endSelect: @escaping((_ index:Int,_ title:String)->Void)){
        showAlertVC(preferredStyle: .alert, title: title, message: message, in: viewController, options: options, endSelect: endSelect)
    }
    
    
    ///弹出选项卡actionSheet
    static func showActionSheet(title:String?=nil, message: String?=nil, in viewController: UIViewController?=UIApplication.shared.keyWindow?.rootViewController,options:[[String:UIAlertAction.Style.RawValue]],
                                endSelect: @escaping((_ index:Int,_ title:String)->Void)) {
        showAlertVC(preferredStyle: .actionSheet, title: title, message: message, in: viewController, options: options, endSelect: endSelect)
    }
    
    private static func showAlertVC(preferredStyle:UIAlertController.Style,title:String?=nil, message: String?=nil, in viewController: UIViewController?=UIApplication.shared.keyWindow?.rootViewController,options:[[String:UIAlertAction.Style.RawValue]],
                             endSelect: @escaping((_ index:Int,_ title:String)->Void)){
        var avc = viewController
        if avc == nil{
            avc = UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for (index,dic) in options.enumerated() {
            let title = dic.keys.first ?? ""
            let style = dic.values.first ?? 0
            let act = UIAlertAction(title: title, style: UIAlertAction.Style.init(rawValue: style) ?? .default) { (act) in
                endSelect(index,title)
            }
            alert.addAction(act)
        }
        avc!.present(alert, animated: true)
    }
    
}
