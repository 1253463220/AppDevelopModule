//
//  WLMaxNumberTextField.swift
//  yunchaodan
//
//  Created by 王立 on 2021/7/10.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

import UIKit

///有最大金额的输入框
@objc class MaxNumberTextField: UITextField,UITextFieldDelegate{
    
    var maxNum : Int64 = 0//最大金额，单位分
    var moneyChanged : ((Int64)->Void)?
    
    init(frame: CGRect = .zero,maxNum:Int64) {
        super.init(frame: frame)
        self.maxNum = maxNum
        self.delegate = self
        self.keyboardType = .decimalPad
        self.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
    }
    
    
    @objc private func textDidChanged(){
        let str = self.text
        if let cent = str?.cent {
            if cent > maxNum {
                self.text = String.init(format: "%.2f", Double(maxNum)/100)
            }
        }
        if let finalCent = self.text?.cent {
            moneyChanged?(finalCent)
        }
    }
    
    //最多输入两位小数
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        let text = textField.text ?? ""
        if text.isEmpty {
            return "0123456789".contains(string)
        }
        if text == "0" {
            return string == "."
        }
        if string == "." {
            if text.isEmpty {
                return false
            }
            if text.contains(".") {
                return false
            }
            return true
        }
        let tobe = (text as NSString).replacingCharacters(in: range, with: string)
        if tobe.hasPrefix("0") && !tobe.hasPrefix("0.") {
            return false
        }
        if tobe.contains(".") {
            guard string != "." else {
                return false
            }
            let array = tobe.components(separatedBy: ".")
            guard array.count == 2 else {
                return false
            }
            let p1 = array[0]
            let p2 = array[1]
            return p1.count < 10 && [1,2].contains(p2.count)
        } else {
            return (tobe.count < 10 && !tobe.hasPrefix("0")) || string == "."
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
