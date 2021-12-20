//
//  WLScroContentView.swift
//  yunchaodan
//
//  Created by 王立 on 2021/6/3.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

import UIKit

@objc open class WLScroContentView: UIView {
    
    public var scroV = UIScrollView()
    private var contentV = UIView()
    public var baseStackV = UIStackView()
    public var contentEdge = UIEdgeInsets.zero{
        didSet{
            self.edgeConstraints.forEach {cons in
                contentV.removeConstraint(cons)
            }
            self.edgeConstraints = [
                baseStackV.topAnchor.constraint(equalTo: self.contentV.topAnchor, constant: contentEdge.top),
                baseStackV.leftAnchor.constraint(equalTo: self.contentV.leftAnchor, constant: contentEdge.left),
                baseStackV.bottomAnchor.constraint(equalTo: self.contentV.bottomAnchor, constant: -contentEdge.bottom),
                baseStackV.rightAnchor.constraint(equalTo: self.contentV.rightAnchor, constant: -contentEdge.right)
            ]
            NSLayoutConstraint.activate(self.edgeConstraints)
        }
    }
    public var itemSpace : CGFloat = 0{
        didSet{
            self.baseStackV.spacing = itemSpace
        }
    }
    private var edgeConstraints = [NSLayoutConstraint]()
    
    public var items = [UIView]()
        
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentEdge = .zero
        self.itemSpace = 0
        self.wl_configUI()
    }
    
    public init(contentEdge:UIEdgeInsets = .zero,itemSpace:CGFloat = 0) {
        super.init(frame: .zero)
        self.contentEdge = contentEdge
        self.itemSpace = itemSpace
        self.wl_configUI()
    }
    
    private func wl_configUI(){
        addSubview(scroV)
        scroV.addSubview(contentV)
        contentV.addSubview(baseStackV)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        scroV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroV.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            scroV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            scroV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            scroV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0)
        ])
        scroV.showsVerticalScrollIndicator = false
        scroV.showsHorizontalScrollIndicator = false
        
        contentV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentV.topAnchor.constraint(equalTo: scroV.topAnchor, constant: 0),
            contentV.leftAnchor.constraint(equalTo: scroV.leftAnchor, constant: 0),
            contentV.bottomAnchor.constraint(equalTo: scroV.bottomAnchor, constant: 0),
            contentV.rightAnchor.constraint(equalTo: scroV.rightAnchor, constant: 0),
            contentV.heightAnchor.constraint(equalTo: scroV.heightAnchor, constant: 0)
        ])
        
        baseStackV.translatesAutoresizingMaskIntoConstraints = false
        edgeConstraints = [
            baseStackV.topAnchor.constraint(equalTo: self.contentV.topAnchor, constant: contentEdge.top),
            baseStackV.leftAnchor.constraint(equalTo: self.contentV.leftAnchor, constant: contentEdge.left),
            baseStackV.bottomAnchor.constraint(equalTo: self.contentV.bottomAnchor, constant: -contentEdge.bottom),
            baseStackV.rightAnchor.constraint(equalTo: self.contentV.rightAnchor, constant: -contentEdge.right)
        ]
        NSLayoutConstraint.activate(edgeConstraints)
        baseStackV.spacing = itemSpace
        
    }
    
    public func add(views:[UIView]){
        for (_,tview) in views.enumerated() {
            baseStackV.addArrangedSubview(tview)
            items.append(tview)
        }
    }
    
    public func clearContent(){
        items.removeAll()
        for subV in baseStackV.subviews {
            subV.removeFromSuperview()
        }
    }
    
    public func enumItemWith(act:(Int,UIView)->Void){
        for (index,itemV) in self.items.enumerated() {
            act(index,itemV)
        }
    }

}
