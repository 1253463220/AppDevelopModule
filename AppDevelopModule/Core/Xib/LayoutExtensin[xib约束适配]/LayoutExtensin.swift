//
//  LayoutExtensin.swift
//  NewEnergy
//
//  Created by 王立 on 2020/11/12.
//  Copyright © 2020 com.ssi. All rights reserved.
//

import Foundation
import UIKit

fileprivate var key : String = "keykey"
fileprivate let kScale : CGFloat = (UIScreen.main.bounds.width/375+UIScreen.main.bounds.height/667)/2

/// 根据屏幕比例变化的约束
class MutableLayoutConstraint: NSLayoutConstraint {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.constant = self.constant*kScale
    }
}


extension UILabel{
    @IBInspectable fileprivate var isFitFont : Bool{
        set{
            objc_setAssociatedObject(self, &key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            return (objc_getAssociatedObject(self, &key) as? Bool) ?? false
        }
    }
    
    open override func awakeFromNib() {
        if self.isFitFont{
            let des = self.font.fontDescriptor
            let font = UIFont(descriptor: des, size: (des.object(forKey: UIFontDescriptor.AttributeName.size) as! CGFloat)*kScale)
            self.font = font
        }
    }
}

extension UIButton{
    @IBInspectable fileprivate var isFitFont : Bool{
        set{
            objc_setAssociatedObject(self, &key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            return (objc_getAssociatedObject(self, &key) as? Bool) ?? false
        }
    }
    
    open override func awakeFromNib() {
        if self.isFitFont,self.titleLabel != nil{
            let des = self.titleLabel!.font.fontDescriptor
            let font = UIFont(descriptor: des, size: (des.object(forKey: UIFontDescriptor.AttributeName.size) as! CGFloat)*kScale)
            self.titleLabel!.font = font
        }
    }
}

extension UITextField{
    
    @IBInspectable fileprivate var isFitFont : Bool{
        set{
            objc_setAssociatedObject(self, &key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            return (objc_getAssociatedObject(self, &key) as? Bool) ?? false
        }
    }
    
    open override func awakeFromNib() {
        if self.isFitFont,self.font != nil{
            let des = self.font!.fontDescriptor
            let font = UIFont(descriptor: des, size: (des.object(forKey: UIFontDescriptor.AttributeName.size) as! CGFloat)*kScale)
            self.font = font
        }
    }
}

extension UITextView{
    @IBInspectable fileprivate var isFitFont : Bool{
        set{
            objc_setAssociatedObject(self, &key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            return (objc_getAssociatedObject(self, &key) as? Bool) ?? false
        }
    }

    open override func awakeFromNib() {
        if self.isFitFont,self.font != nil{
            let des = self.font!.fontDescriptor
            let font = UIFont(descriptor: des, size: (des.object(forKey: UIFontDescriptor.AttributeName.size) as! CGFloat)*kScale)
            self.font = font
        }
    }
}
