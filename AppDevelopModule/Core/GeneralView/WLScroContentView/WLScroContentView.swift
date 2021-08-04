//
//  WLScroContentView.swift
//  yunchaodan
//
//  Created by 王立 on 2021/6/3.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

import UIKit

@objc class WLScroContentView: UIView {
    
    private var scroV = UIScrollView()
    private var contentV = UIView()
    private var baseStackV = UIStackView()
    var contentEdge = UIEdgeInsets.zero
    var itemSpace : CGFloat = 0{
        didSet{
            baseStackV.spacing = itemSpace
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(contentEdge:UIEdgeInsets,itemSpace:CGFloat) {
        super.init(frame: .zero)
        self.contentEdge = contentEdge
        self.itemSpace = itemSpace
        self.configUI()
    }
    
    func configUI(){
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
        NSLayoutConstraint.activate([
            baseStackV.topAnchor.constraint(equalTo: self.contentV.topAnchor, constant: contentEdge.top),
            baseStackV.leftAnchor.constraint(equalTo: self.contentV.leftAnchor, constant: contentEdge.left),
            baseStackV.bottomAnchor.constraint(equalTo: self.contentV.bottomAnchor, constant: -contentEdge.bottom),
            baseStackV.rightAnchor.constraint(equalTo: self.contentV.rightAnchor, constant: -contentEdge.right)
        ])
        baseStackV.spacing = itemSpace
        
    }
    
    func add(views:[UIView]){
        for (_,tview) in views.enumerated() {
            baseStackV.addArrangedSubview(tview)
        }
    }

}