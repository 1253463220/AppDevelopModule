//
//  WLMenuView.swift
//  BteHotel
//
//  Created by 王立 on 2021/9/25.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

import UIKit

public class WLMenuView: WLScroContentView {
    
    public typealias IndicatorUIConfigAct = (_ index:Int?,_ itemV:WLMenuItemView?,_ menuV:WLMenuView)->UIView
    public typealias IndicatorIndexChangeAct = (_ index:Int?,_ itemV:WLMenuItemView?,_ menuV:WLMenuView,_ indicatorV:UIView?)->Void
    private(set) var itemArr = [WLMenuItemView]()
    private(set) var defaultIndex : Int? = 0
    private(set) var selectedIndex : Int?
    public var indexWillChanged : ((_ index:Int,_ itemV:WLMenuItemView)->Bool)?
    public var indexDidChanged : ((_ index:Int,_ itemV:WLMenuItemView)->Void)?
    private var indicatorV : UIView?//指示view
    private var selectedItemV : WLMenuItemView?
    private var indicatorIndexChangeAct : IndicatorIndexChangeAct?
    // MARK: 生命周期
    public init(itemArr:[WLMenuItemView],selectedIndex:Int? = 0,itemSpace:CGFloat = 0) {
        super.init(contentEdge: .zero, itemSpace: itemSpace)
        self.itemArr = itemArr
        self.defaultIndex = selectedIndex
        self.selectedIndex = selectedIndex
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: 界面
    public func updateUI() {
        UIView.performWithoutAnimation {
            self.clearContent()
            if self.selectedIndex ?? 0 >= itemArr.count {
                self.selectedIndex = defaultIndex
            }
            for (index,itemV) in itemArr.enumerated() {
                if index == selectedIndex {
                    self.selectedItemV = itemV
                    itemV.selectUIConfig(itemV)
                }else{
                    itemV.normalUIConfig(itemV)
                }
                itemV.addTapAction {[weak self] ges in
                    guard let self = self else {return}
                    self.tap(index: index)
                }
            }
            add(views: itemArr)
            self.indicatorIndexChangeAct?(self.selectedIndex,self.selectedItemV,self,self.indicatorV)
        }
    }
    
    public func updateMenuItems(itemArr:[WLMenuItemView],defaultIndex:Int? = 0){
        self.itemArr = itemArr
        self.defaultIndex = defaultIndex
        updateUI()
    }
    
    public func configIndicator(configAct:@escaping IndicatorUIConfigAct,indexChangeAct:@escaping IndicatorIndexChangeAct){
        guard let tSelectIndex = self.selectedIndex else {return}
        guard let tSelectItemV = self.selectedItemV else {return}
        self.indicatorV = configAct(tSelectIndex,tSelectItemV,self)
        self.indicatorIndexChangeAct = indexChangeAct
    }
    
    // MARK: 数据
    
    // MARK: 事件
    @objc private func tap(index:Int){
        gotoIndex(index)
    }
    
    // MARK: 逻辑
    func gotoIndex(_ index:Int?,animated:Bool = true){
        guard let index = index,index != selectedIndex else {return}
        guard index >= 0,index < itemArr.count else {return}
        
        let itemV = self.itemArr[index]
        let act : (()->Void) = {
            let shouldContinue = self.indexWillChanged?(index, itemV) ?? true
            if shouldContinue {
                if self.selectedItemV != nil {
                    self.selectedItemV?.normalUIConfig(self.selectedItemV!)
                }
                self.selectedIndex = index
                self.selectedItemV = itemV
                self.indexDidChanged?(index,itemV)
                self.selectedItemV?.selectUIConfig(itemV)
                self.indicatorIndexChangeAct?(index,itemV,self,self.indicatorV)
            }
        }
        
        if animated {
            UIView.animate(withDuration: 0.2) {
                act()
            } completion: { isCom in
                self.centerItem(itemV: itemV,animated: true)
            }

        }else{
            act()
            self.centerItem(itemV: itemV,animated: false)
        }
        
    }
    
    private func centerItem(itemV:WLMenuItemView,animated:Bool){
        
        let act = {
            let position = itemV.convert(CGPoint.init(x: itemV.frame.width/2, y: 0), to: self)
            let space = self.frame.width/2-position.x
            var x = self.scroV.contentOffset.x-space
            x = max(0, x)
            x = min(self.scroV.contentSize.width-self.scroV.frame.width, x)
            self.scroV.setContentOffset(CGPoint.init(x: x, y: 0), animated: false)
        }
        if animated {
            UIView.animate(withDuration: 0.2, delay: 0.05, options: .curveEaseIn) {
                act()
            } completion: { isCom in
                
            }
        }else{
            act()
        }
    }
    
    // MARK: 代理
    
    // MARK: lazy
    
}


open class WLMenuItemView: UIButton {
    public typealias UIConfig = (WLMenuItemView)->Void
    public var normalUIConfig : UIConfig!
    public var selectUIConfig : UIConfig!
    
    public init(normalUIConfig:@escaping UIConfig,selectUIConfig:@escaping UIConfig) {
        super.init(frame: .zero)
        self.normalUIConfig = normalUIConfig
        self.selectUIConfig = selectUIConfig
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}




///复选视图
public class WLMultipleChooseView: WLScroContentView {
    private(set) var itemArr = [WLMenuItemView]()
    private(set) var selectedIndexs = [Int]()
    var indexWillSelected : ((_ currentSelectIndex:Int,_ currentSelectItemV:WLMenuItemView)->Bool)?
    var indexEndSelected : ((_ allSelectIndexs:[Int],_ allSelectItemVs:[WLMenuItemView])->Void)?
    
    // MARK: 生命周期
    public init(itemArr:[WLMenuItemView],selectedIndexs:[Int] = [],itemSpace:CGFloat = 0) {
        super.init(contentEdge: .zero, itemSpace: itemSpace)
        self.itemArr = itemArr
        self.selectedIndexs = selectedIndexs
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: 界面
    private func configUI() {
        for (index,itemV) in itemArr.enumerated() {
            if selectedIndexs.contains(index) {
                itemV.selectUIConfig(itemV)
            }else{
                itemV.normalUIConfig(itemV)
            }
            itemV.addTapAction {[weak self] ges in
                guard let self = self else {return}
                self.tap(index: index)
            }
        }
        add(views: itemArr)
    }
    // MARK: 数据
    
    // MARK: 事件
    @objc private func tap(index:Int){
        if self.selectedIndexs.contains(index) {
            var arr = selectedIndexs
            arr.removeAll(where: {$0 == index})
            changeSelectedIndexs(arr)
        }else{
            changeSelectedIndexs(selectedIndexs+[index])
        }
    }
    
    // MARK: 逻辑
    public func changeSelectedIndexs(_ indexs:[Int],animated:Bool = true){
        let act : (()->Void) = {
            for index in self.selectedIndexs {
                let itemV = self.itemArr[index]
                itemV.normalUIConfig(itemV)
            }
            var allSelectItemArr = [WLMenuItemView]()
            for index in indexs {
                let itemV = self.itemArr[index]
                allSelectItemArr.append(itemV)
                let shouldContinue = self.indexWillSelected?(index, itemV) ?? true
                var finalIndexArr = [Int]()
                if shouldContinue {
                    finalIndexArr.append(index)
                    itemV.selectUIConfig(itemV)
                }
            }
            self.selectedIndexs = indexs
            self.indexEndSelected?(indexs,allSelectItemArr)
        }
        
        if animated {
            UIView.animate(withDuration: 0.2) {
                act()
            }
        }else{
            act()
        }
        
    }
    
    // MARK: 代理
    
    // MARK: lazy
}
