//
//  WLMenuView.swift
//  BteHotel
//
//  Created by Admin on 2021/9/25.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

import UIKit

class WLMenuView: WLScroContentView {
    
    typealias IndicatorUIConfigAct = (_ index:Int,_ itemV:WLMenuItemView)->UIView
    private(set) var itemArr = [WLMenuItemView]()
    private(set) var selectedIndex : Int?
    var indexWillChanged : ((_ index:Int,_ itemV:WLMenuItemView)->Bool)?
    var indexDidChanged : ((_ index:Int,_ itemV:WLMenuItemView)->Void)?
    private var indicatorV : UIView?//指示view
    private var selectedItemV : WLMenuItemView?
    private var indicatorConfig : IndicatorUIConfigAct?
    // MARK: 生命周期
    init(itemArr:[WLMenuItemView],selectedIndex:Int? = 0,itemSpace:CGFloat = 0) {
        super.init(contentEdge: .zero, itemSpace: itemSpace)
        self.itemArr = itemArr
        self.selectedIndex = selectedIndex
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: 界面
    private func configUI() {
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
    }
    
    func configIndicator(configAct:@escaping IndicatorUIConfigAct){
        guard let tSelectIndex = self.selectedIndex else {return}
        guard let tSelectItemV = self.selectedItemV else {return}
        self.indicatorV = configAct(tSelectIndex,tSelectItemV)
        self.indicatorConfig = configAct
        self.addSubview(self.indicatorV!)
    }
    
    // MARK: 数据
    
    // MARK: 事件
    @objc private func tap(index:Int){
        gotoIndex(index)
    }
    
    // MARK: 逻辑
    func gotoIndex(_ index:Int,animated:Bool = true){
        guard index != selectedIndex else {return}
        guard index >= 0,index < itemArr.count else {return}
        
        let act : (()->Void) = {
            let itemV = self.itemArr[index]
            let shouldContinue = self.indexWillChanged?(index, itemV) ?? true
            if shouldContinue {
                if self.selectedItemV != nil {
                    self.selectedItemV?.normalUIConfig(self.selectedItemV!)
                }
                self.selectedIndex = index
                self.selectedItemV = itemV
                self.indexDidChanged?(index,itemV)
                self.selectedItemV?.selectUIConfig(itemV)
                _ = self.indicatorConfig?(index,itemV)
            }
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


class WLMenuItemView: UIButton {
    typealias UIConfig = (WLMenuItemView)->Void
    var normalUIConfig : UIConfig!
    var selectUIConfig : UIConfig!
    var titleStr = ""
    
    init(normalUIConfig:@escaping UIConfig,selectUIConfig:@escaping UIConfig,title:String) {
        super.init(frame: .zero)
        self.titleStr = title
        self.normalUIConfig = normalUIConfig
        self.selectUIConfig = selectUIConfig
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}




///复选视图
class WLMultipleChooseView: WLScroContentView {
    private(set) var itemArr = [WLMenuItemView]()
    private(set) var selectedIndexs = [Int]()
    var indexWillSelected : ((_ currentSelectIndex:Int,_ currentSelectItemV:WLMenuItemView)->Bool)?
    var indexEndSelected : ((_ allSelectIndexs:[Int],_ allSelectItemVs:[WLMenuItemView])->Void)?
    
    // MARK: 生命周期
    init(itemArr:[WLMenuItemView],selectedIndexs:[Int] = [],itemSpace:CGFloat = 0) {
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
    func changeSelectedIndexs(_ indexs:[Int],animated:Bool = true){
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
