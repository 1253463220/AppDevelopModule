//
//  ViewController.swift
//  AppDevelopExample
//
//  Created by 王立 on 2020/9/10.
//  Copyright © 2020 王立. All rights reserved.
//

import UIKit
import AppDevelopModule

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tview = WLMenuView.init(itemArr: ["111","222","333","111","222","333","111","222","333","111","222","333"].map({KKItemView.init(title: $0)}), selectedIndex: 0, itemSpace: 20)
        tview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tview)
        NSLayoutConstraint.activate([
            tview.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            tview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tview.heightAnchor.constraint(equalToConstant: 30),
            tview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
        view.backgroundColor = .orange
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            print(tview)
        }
        tview.indexDidChanged = { (index,itemV) in

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

class KKItemView: WLMenuItemView {
    init(title:String) {
        super.init { itemV in
            itemV.setTitleColor(.red, for: .selected)
            itemV.isSelected = true
        } selectUIConfig: { itemV in
            itemV.setTitleColor(.green, for: .normal)
            itemV.isSelected = false
        }
        self.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}



