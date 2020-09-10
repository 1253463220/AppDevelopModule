//
//  Algorithms.swift
//  AppDevelopModule
//
//  Created by 王立 on 2020/9/10.
//

import Foundation

/*
 给定一个数组，数组中无重复数字，数组中元素个数为n，将数组中任意m个数(m<n)放入新的数组中，并按照m个数的和的大小从小到大进行排序，和相同时比较数组里的元素从小到大。输出最终的数组。
 
 如：数组为[1,2,3]，m为2，则新数组为：
 [[1,2], [1,3], [2,1], [2,3], [3,1], [3,2]]
 按照和的大小进行排序，和相同时比较数组里的元素从小到大，就是：
 [[1,2], [2,1], [1,3], [3,1], [2,3], [3,2]]
 **/
public struct FuncTool {
    
    public func getResultArray(orgArr:[Int],targetCount:Int)->[[Int]]{
        var finalArr : [[Int]] = []
        var tempArr : [Int] = Array(repeating: 0, count: targetCount)
        reCallToBuildArr(orgArr: orgArr, deepIndex: targetCount, tempArr: &tempArr, finalArr: &finalArr)
        return sortTwoDimensional(arr: finalArr)
    }

    func reCallToBuildArr(orgArr:[Int],deepIndex:Int,tempArr:inout [Int],finalArr:inout [[Int]]){
        for num in orgArr {
            let orgArr1 = orgArr.filter{$0 != num}
            tempArr[deepIndex-1] = num
            if deepIndex == 1{
                finalArr.append(tempArr)
                continue
            }
            reCallToBuildArr(orgArr: orgArr1, deepIndex: deepIndex-1, tempArr: &tempArr, finalArr: &finalArr)
        }
    }

    func sortTwoDimensional(arr:[[Int]])->[[Int]]{
        return arr.sorted { (arr1, arr2) -> Bool in
            let sum1 = arr1.reduce(0) { (result, num) -> Int in
                return result+num
            }
            let sum2 = arr2.reduce(0) { (result, num) -> Int in
                return result+num
            }
            switch (sum1,sum2) {
            case _ where sum1 > sum2 :
                return false
            case _ where sum1 < sum2 :
                return true
            case _ where sum1 == sum2 :
                for index in 0..<arr1.count {
                    let tNum1 = arr1[index]
                    let tNum2 = arr2[index]
                    if tNum1 == tNum2{
                        continue
                    }else{
                        return tNum1 < tNum2
                    }
                }
                return true
            default:
                return true
            }
        }
    }
    
}
