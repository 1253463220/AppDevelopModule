//
//  MaxLengthTextField.swift
//  yunchaodan
//
//  Created by 王立 on 2021/7/22.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

import UIKit

class MaxLengthTextField: UITextField {

    var maxLength : Int = 0//最大字符个数
    var textChanged : ((String?)->Void)?
    
    init(frame: CGRect = .zero,maxLength:Int) {
        super.init(frame: frame)
        self.maxLength = maxLength
        self.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
    }
    
    
    @objc private func textDidChanged(){
        let textStr = self.text ?? ""
        let mode = UITextInputMode.activeInputModes.first
        let lang = mode?.primaryLanguage
        if let languge = lang,languge == "zh-Hans" {
            let range = self.markedTextRange ?? UITextRange.init()
            let position = self.position(from: range.start, offset: 0)
            if position == nil {
                if textStr.count > maxLength {
                    self.text = (textStr as NSString).substring(to: maxLength)
                }
            }
        }else{
            if textStr.count > maxLength {
                self.text = (textStr as NSString).substring(to: maxLength)
            }
        }
        textChanged?(self.text)
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
