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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.present(TestVC(), animated: true, completion: nil)
    }
    
}



