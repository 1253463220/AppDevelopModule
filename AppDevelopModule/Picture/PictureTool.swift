//
//  PictureTool.swift
//  Example
//
//  Created by 王立 on 2020/9/7.
//  Copyright © 2020 王立. All rights reserved.
//

import Foundation
import Kingfisher
import JXPhotoBrowser


public struct PictureTool{
    ///移除图片缓存,包括内存缓存、硬盘缓存
    public static func removeImageCache(imgUrlStr:String){
        if let url = URL(string: imgUrlStr){
            ImageCache.default.removeImage(forKey: url.cacheKey)
        }
    }
    ///缓存网络图片
    public static func storeImage(image:UIImage,imgUrlStr:String){
        if let url = URL(string: imgUrlStr){
            ImageCache.default.store(image, forKey: url.cacheKey)
        }
    }
}

