//
//  AppkeychainIdentifer.h
//  EmptyAPP
//
//  Created by 王立 on 2018/9/26.
//  Copyright © 2018年 王立. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppKeychainIdentifer : NSObject

/**
 本方法是得到 UUID 后存入系统中的 keychain 的方法
 不用添加 plist 文件
 程序删除后重装,仍可以得到相同的唯一标示
 但是当系统刷机后,系统中的钥匙串会被清空,此时本方法失效
 */
+(NSString *)getDeviceIDInKeychain;

@end

NS_ASSUME_NONNULL_END
