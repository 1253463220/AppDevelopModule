//
//  WLTextView.swift
//  yunchaodan
//
//  Created by 王立 on 2021/8/4.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

import UIKit

@objc class WLTextView: KMPlaceholderTextView {
    
    @objc var limitTextCount : Int = -1
    @objc var autoChangeHeight = false
    @objc var minHeight : CGFloat = -1
    @objc var maxHeight : CGFloat = -1
    @objc var heightChangeBlock : ((_ textView:WLTextView,_ height:CGFloat)->Void)?
    @objc var textChangedBlock : ((_ textView:WLTextView,_ text:String)->Void)?
    
    private var lastText : String?//最后一次处理后的文字
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.lineFragmentPadding = 0
        self.textContainerInset = .zero
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(noti:)), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    
    @objc private func textChanged(noti:Notification){
        if let textView = noti.object as? WLTextView,textView == self{
            if limitTextCount > 0 { //文字个数限制
                let textStr = textView.text ?? ""
                let mode = UITextInputMode.activeInputModes.first
                let lang = mode?.primaryLanguage
                if let languge = lang,languge == "zh-Hans" {
                    let range = textView.markedTextRange ?? UITextRange.init()
                    let position = textView.position(from: range.start, offset: 0)
                    if position == nil {
                        if textStr.count > limitTextCount {
                            self.text = textStr.substring(toIndex: limitTextCount)
                        }
                    }
                }else{
                    if textStr.count > limitTextCount {
                        self.text = textStr.substring(toIndex: limitTextCount)
                    }
                }
            }
            guard self.lastText != self.text else {
                return
            }
            lastText = self.text
            
            if autoChangeHeight, minHeight > 0, maxHeight > 0 { //高度限制
                var finalH = self.contentH
                if finalH < minHeight {
                    finalH = minHeight
                }else if finalH > maxHeight{
                    finalH = maxHeight
                }
                for cons in self.constraints {
                    if cons.firstAnchor == self.heightAnchor {
                        cons.constant = finalH
                    }
                }
                self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: finalH)
                self.heightChangeBlock?(self,finalH)
            }
            self.textChangedBlock?(self,self.text)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
