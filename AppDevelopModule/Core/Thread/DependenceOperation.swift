//
//  DependenceOperation.swift
//  Example
//
//  Created by 王立 on 2020/9/9.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation


open class DependenceOperation: Operation {
    
    typealias AsyncOperationBlock = (_ operation:DependenceOperation)->Void
    
    private var ml_executing = false{
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    private var ml_finished = false{
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    private var actBlock:AsyncOperationBlock?
    
    override open var isAsynchronous:Bool {
        return true
    }
    
    override open var isConcurrent:Bool {
        return true
    }
    
    override open var isFinished:Bool{
        return ml_finished
    }
    
    override open var isExecuting:Bool{
        return ml_executing
    }
    
    convenience init(operationBlock:@escaping AsyncOperationBlock) {
        self.init()
        actBlock = operationBlock
    }
    
    override open func start() {
        if isCancelled {
            ml_finished = true
            return
        }
        ml_executing = true
        actBlock?(self)
    }
    
    open func finishOperation(){
        ml_executing = false
        ml_finished = true
    }
    
    deinit{
        print("operation deinited")
    }
    
    
    public static func createQueue(operations:()->[DependenceOperation],finishAct:()->DependenceOperation,maxRunCount:Int){
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = maxRunCount
        
        operations().forEach { (tOper) in
            finishAct().addDependency(tOper)
            queue.addOperation(tOper)
        }
        queue.addOperation(finishAct())
    }
    
}
