//
//  DataExtension.swift
//  Example
//
//  Created by 王立 on 2020/9/3.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation
import CommonCrypto

//Data类型md5
extension Data {
    
    var md5Str : String{
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ = withUnsafeBytes { (bytes) in
            CC_MD5(bytes, CC_LONG(count), &digest)
        }
        var digestHex = ""
        for index in 0 ..< Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02X", digest[index])
        }
        return digestHex
    }
    
    func saveToPath(_ path:String)->URL?{
        let isExist = FileManager.default.fileExists(atPath: path)
        if isExist {
            do {
                try FileManager.default.removeItem(atPath: path)
            }  catch {
                return nil
            }
        }
        FileManager.default.createFile(atPath: path, contents: self, attributes: nil)
        return URL(fileURLWithPath: path)
    }
}


