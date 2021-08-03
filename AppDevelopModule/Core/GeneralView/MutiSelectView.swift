//
//  MutiSelectView.swift
//  cdz-ios
//
//  Created by 王立 on 2020/7/15.
//  Copyright © 2020 王立. All rights reserved.
//

import UIKit

public protocol MutiSelectProtocol {
    var cellStr : String { get }
}

public class MutiSelectBaseCell : UITableViewCell{
    func updateUIWithCellStr(){}
}

public class MutiSelectView: WindowCallOutView ,UITableViewDelegate,UITableViewDataSource{
    public typealias EndSelect = ([MutiSelectProtocol])->Void
    private var contentV = UIView()
    lazy private var tableV = UITableView(frame: .zero, style: .plain)
    private var dataArr = [MutiSelectProtocol]()
    private var selectedArr = [MutiSelectProtocol]()
    private var endAct : EndSelect?
    
    private let padding : CGFloat = 5
    private let rowHeight : CGFloat = 40
    private let btnH : CGFloat = 40
    lazy private var tableH : CGFloat = {
        var tableH = CGFloat(dataArr.count)*rowHeight
        if tableH >= 200{
            tableH = 200
        }
        if tableH <= rowHeight{
            tableH = rowHeight
        }
        return tableH
    }()
    lazy private var contentH : CGFloat = {
        return tableH+btnH+3*padding
    }()
    // MARK: 生命周期
    public convenience init(endAct:@escaping EndSelect,dataArr:[MutiSelectProtocol],selectedArr:[MutiSelectProtocol]=[],cellClass:MutiSelectBaseCell.Type) {
        self.init()
        self.dataArr = dataArr
        self.selectedArr = selectedArr
        self.endAct = endAct
        self.shouldTapDismiss = true
        tableV.register(cellClass, forCellReuseIdentifier: "MutiSelectBaseCell")
        configUI()
    }
    // MARK: 界面
    private func configUI() {
        
        contentV.addSubview(tableV)
        self.addSubview(contentV)
        contentV.bounds = CGRect(x: 0, y: 0, width: vmsi.width*2/3, height: contentH)
        contentV.center = CGPoint(x: vmsi.width/2, y: vmsi.height/2)
        contentV.layer.cornerRadius = 4
        contentV.layer.masksToBounds = true
        contentV.backgroundColor = .white
        
        tableV.delegate = self
        tableV.dataSource = self
        tableV.tableFooterView = UIView()
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableV.frame = CGRect(x: 5, y: padding, width: contentV.frame.size.width-2*padding, height: tableH)
        tableV.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let btn = UIButton(type: .system)
        btn.setTitle("确定", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.bounds = CGRect(x: 0, y: 0, width: contentV.frame.size.width, height: btnH)
        btn.center = CGPoint(x: contentV.frame.size.width/2, y: tableV.frame.maxY+20+padding)
        btn.addTarget(self, action: #selector(tapSure), for: .touchUpInside)
        contentV.addSubview(btn)
    }
    
    // MARK: 数据
    
    // MARK: 事件
    @objc private func tapSure(){
        self.endAct?(self.selectedArr)
        self.dismiss()
    }
    // MARK: 逻辑
    
    // MARK: 代理
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = dataArr[indexPath.row]
        cell.textLabel?.text = model.cellStr
        let isContain = selectedArr.contains { (tModel) -> Bool in
            return tModel.cellStr == model.cellStr
        }
        if isContain{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArr[indexPath.row]
        var isContain = false
        var index : Int?
        for (tIndex,tModel) in selectedArr.enumerated() {
            if tModel.cellStr == model.cellStr{
                isContain = true
                index = tIndex
            }
        }
        if isContain{
            selectedArr.remove(at: index!)
        }else{
            selectedArr.append(model)
        }
        tableView.reloadData()
    }
    
    public override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if let tview = touch.view,
            NSStringFromClass(tview.classForCoder) == "UITableViewCellContentView" ||
            NSStringFromClass(tview.classForCoder) == "UITableViewCell" ||
            tview == contentV ||
            tview == tableV{
            return false
        }
        return true
    }
    
}

