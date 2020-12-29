//
//  AuthorizationManager.h
//  MiniApp
//
//  Created by 王立 on 2017/4/1.
//  Copyright © 2017年 王立. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AuthorizationType) {
    AuthorizationTypePhotoLibrary = 1,
    AuthorizationTypeCamera,
    AuthorizationTypeLocation,
    AuthorizationTypeMicrophone,
    AuthorizationTypeContacts,
    AuthorizationTypeBlueTooth,
    AuthorizationTypeNotification,
    AuthorizationTypeNetWork,
    AuthorizationTypeCalendar,
    AuthorizationTypeReminder,
};

@interface AuthorizationManager : NSObject

+(void)checkAuthorization:(AuthorizationType)authorizationType passblock:(dispatch_block_t)passblock;

/**
相册权限开关
*/
+ (BOOL)authorizationForPhotoLibrary;
/**
相机权限开关
*/
+ (BOOL)authorizationForCamera;
/**
定位权限开关
*/
+ (BOOL)authorizationForLocation;
/**
麦克风权限开关
*/
+ (BOOL)authorizationForMicrophone;
/**
联系人权限开关
*/
+ (BOOL)authorizationForContacts;
/**
蓝牙权限开关
*/
+ (BOOL)authorizationForBlueTooth;
/**
推送权限开关
*/
+ (BOOL)authorizationForNotification;
/**
连网权限开关
*/
+ (BOOL)authorizationForNetWork;
/**
日历权限开关
*/
+ (BOOL)authorizationForCalendar;
/**
备忘录权限开关
*/
+ (BOOL)authorizationForReminder;

@end
