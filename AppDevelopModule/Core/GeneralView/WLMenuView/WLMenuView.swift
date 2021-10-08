//
//  WLMenuView.swift
//  BteHotel
//
//  Created by Admin on 2021/9/25.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

import UIKit

class WLMenuView: WLScroContentView {
    
    private var itemArr = [WLMenuItemView]()
    var selectedIndex : Int?
    var indexWillChanged : ((Int,WLMenuItemView)->Bool)?
    var indexDidChanged : ((Int,WLMenuItemView)->Void)?
    private var selectedItemV : WLMenuItemView?
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
            itemV.addTapAction {[weak self,weak itemV] ges in
                guard let sItemV = itemV else {return}
                guard let self = self else {return}
                self.tap(index: index, itemV: sItemV)
            }
        }
        add(views: itemArr)
    }
    
    // MARK: 数据
    
    // MARK: 事件
    @objc private func tap(index:Int,itemV:WLMenuItemView){
        guard index != selectedIndex else {return}
        let shouldContinue = self.indexWillChanged?(index, itemV) ?? true
        if shouldContinue {
            if self.selectedItemV != nil {
                self.selectedItemV?.normalUIConfig(self.selectedItemV!)
            }
            self.selectedIndex = index
            self.selectedItemV = itemV
            self.indexDidChanged?(index,itemV)
            self.selectedItemV?.selectUIConfig(itemV)
        }
    }
    
    // MARK: 逻辑
    
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
