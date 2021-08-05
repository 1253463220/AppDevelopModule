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
                doLimitTextCount(textView: textView)
            }
            guard self.lastText != self.text else {
                return
            }
            lastText = self.text
            self.textChangedBlock?(self,self.text)
            
            if autoChangeHeight, minHeight > 0, maxHeight > 0 { //高度限制
                updateHieght()
                self.heightChangeBlock?(self,self.fitHeight())
            }
        }
    }
    
    private func doLimitTextCount(textView:UITextView){
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
    
    @objc func fitHeight()->CGFloat{
        if minHeight == -1 || maxHeight == -1 {
            return self.contentH
        }
        var finalH = self.contentH
        if finalH < minHeight {
            finalH = minHeight
        }else if finalH > maxHeight{
            finalH = maxHeight
        }
        return finalH
    }
    
    ///updateAction返回值：是否执行默认操作
    @objc func updateHieght(_ updateAction:(()->Bool)? = nil){
        DispatchQueue.main.async {//不要删除这个异步操作
            let doDefaultAction = updateAction?() ?? true
            
            if doDefaultAction{
                let finalH = self.fitHeight()
                for cons in self.constraints {
                    if cons.firstAnchor == self.heightAnchor {
                        cons.constant = finalH
                    }
                }
                self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: finalH)
            }
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
