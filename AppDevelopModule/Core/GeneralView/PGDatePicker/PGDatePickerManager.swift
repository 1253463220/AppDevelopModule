//
//  PGDatePickerManager.swift
//  LQVehicleOwner
//
//  Created by 陈文轩 on 2020/5/3.
//  Copyright © 2020 com.ssi. All rights reserved.
//

import Foundation

public class PGDatePickerManager {
    
    /// 显示通用的时间选择器,标题固定为 "选择时间"
    /// - Parameters:
    ///   - viewController: 显示在哪个VC上
    ///   - initialDate: 初始化date,默认显示当前时间
    ///   - datePickerMode: 选择模式
    ///   - completeHandler: 完成回调
    static func showPicker(in viewController: UIViewController, initialDate: Date? = nil, datePickerMode: PGDatePickerMode, completeHandler:@escaping (Date)->Void) {
        
        let datePickerManager = PGDatePickManager()
        datePickerManager.isShadeBackground = true
        datePickerManager.cancelButtonTextColor = UIColor(red: 253/255.0, green: 45/255.0, blue: 60/255.0, alpha: 1)
        datePickerManager.confirmButtonTextColor = UIColor(red: 253/255.0, green: 45/255.0, blue: 60/255.0, alpha: 1)
        datePickerManager.titleLabel.textColor = .black
        datePickerManager.headerViewBackgroundColor = .white
        datePickerManager.titleLabel.text = "选择时间"
        
        let datePicker = datePickerManager.datePicker!
        datePicker.lineBackgroundColor = UIColor(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1)
        datePicker.textColorOfSelectedRow = UIColor.black
        datePicker.textColorOfOtherRow = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1)
        datePicker.datePickerMode = datePickerMode
        datePicker.selectedDate = { comeponts in
            if let component = comeponts,
                let date = Calendar.current.date(from: component) {
                completeHandler(date)
            }
        }
        
        if let initialDate = initialDate {
            datePicker.setDate(initialDate)
        }
        
        viewController.present(datePickerManager, animated: false, completion: nil)
    }
    
    
}


