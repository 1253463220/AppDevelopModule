////
////  AuthorizationManager.m
////  MiniApp
////
////  Created by 王立 on 2017/4/1.
////  Copyright © 2017年 王立. All rights reserved.
////
//
//#import "AuthorizationManager.h"
//#import <UIKit/UIKit.h>
//#import <AVFoundation/AVFoundation.h>
//#import <Photos/Photos.h>
//#import <AssetsLibrary/AssetsLibrary.h>
//@import CoreTelephony;
//#import <UserNotifications/UserNotifications.h>
//#import <CoreLocation/CoreLocation.h>
//#import <AddressBook/AddressBook.h>
//#import <Contacts/Contacts.h>
//#import <EventKit/EventKit.h>
//#import <CoreBluetooth/CoreBluetooth.h>
//
//
////手机系统版本号
//#define SYSTEMVERSION [[[UIDevice currentDevice]systemVersion]floatValue]
//@implementation AuthorizationManager
//
//+(void)checkAuthorization:(AuthorizationType)authorizationType passblock:(dispatch_block_t)passblock;
//{
//    if (authorizationType == AuthorizationTypePhotoLibrary){
//        if ([self authorizationForPhotoLibrary]) {
//            if (passblock) {
//                passblock();
//            }
//        }else{
//            [self alertTitle:@"访问照片权限被禁用" description:@"照片"];
//        }
//    }else if (authorizationType == AuthorizationTypeCamera) {
//
//        if([self authorizationForCamera]){
//            if (passblock) {
//                passblock();
//            }
//        }else{
//            [self alertTitle:@"访问相机权限被禁用" description:@"相机"];
//        }
//    }else if (authorizationType == AuthorizationTypeLocation){
//        if ([self authorizationForLocation]) {
//            if (passblock) {
//                passblock();
//            }
//        }else{
//            [self alertTitle:@"访问位置权限被禁用" description:@"位置"];
//        }
//    }else if (authorizationType == AuthorizationTypeMicrophone){
//        if ([self authorizationForMicrophone]) {
//            if (passblock) {
//                passblock();
//            }
//        }else{
//            [self alertTitle:@"访问麦克风权限被禁用" description:@"麦克风"];
//        }
//    }else if (authorizationType == AuthorizationTypeContacts){
//        if ([self authorizationForContacts]) {
//            if (passblock) {
//                passblock();
//            }
//        }else{
//            [self alertTitle:@"访问联系人权限被禁用" description:@"联系人"];
//        }
//    }else if (authorizationType == AuthorizationTypeBlueTooth){
//        if ([self authorizationForBlueTooth]) {
//            if (passblock) {
//                passblock();
//            }
//        }else{
//            [self alertTitle:@"访问蓝牙权限被禁用" description:@"蓝牙"];
//        }
//    }else if (authorizationType == AuthorizationTypeNotification){
//        if ([self authorizationForNotification]) {
//            if (passblock) {
//                passblock();
//            }
//        }else{
//            [self alertTitle:@"通知权限被禁用" description:@"通知"];
//        }
//    }else if (authorizationType == AuthorizationTypeNetWork){
//        if ([self authorizationForNetWork]) {
//            if (passblock) {
//                passblock();
//            }
//        }else{
//            [self alertTitle:@"访问无线数据权限被禁用" description:@"无线数据"];
//        }
//    }else if (authorizationType == AuthorizationTypeCalendar){
//        if ([self authorizationForCalendar]) {
//            if (passblock) {
//                passblock();
//            }
//        }else{
//            [self alertTitle:@"访问日历权限被禁用" description:@"日历"];
//        }
//    }else if (authorizationType == AuthorizationTypeReminder){
//        if ([self authorizationForReminder]) {
//            if (passblock) {
//                passblock();
//            }
//        }else{
//            [self alertTitle:@"访问备忘录权限被禁用" description:@"备忘录"];
//        }
//    }
//
//}
//#pragma mark - 相册权限
//+(BOOL)authorizationForPhotoLibrary
//{
//    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
//    if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusNotDetermined) {
//        return NO;
//    }
//    return YES;
//}
//
//#pragma mark - 相机权限
//+(BOOL)authorizationForCamera
//{
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
//        return NO;
//    }
//    return YES;
//}
//
//#pragma mark - 定位权限
//+(BOOL)authorizationForLocation
//{
//    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
//    if (authStatus==kCLAuthorizationStatusDenied || authStatus==kCLAuthorizationStatusRestricted || authStatus==kCLAuthorizationStatusNotDetermined) {
//        return NO;
//    }
//    return YES;
//}
//
//#pragma mark - 麦克风权限
//+ (BOOL)authorizationForMicrophone{
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
//    if (authStatus==AVAuthorizationStatusNotDetermined || authStatus==AVAuthorizationStatusRestricted || authStatus==AVAuthorizationStatusDenied){
//        return NO;
//    }else if (authStatus==AVAuthorizationStatusAuthorized){
//        return YES;
//    }
//    return YES;
//}
//#pragma mark - 联系人权限
//+ (BOOL)authorizationForContacts{
//    if (SYSTEMVERSION >= 9.0) {
//        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
//        if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted){
//            return NO;
//        }
//    }else{
//        ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
//        if (ABstatus == kABAuthorizationStatusDenied || ABstatus == kABAuthorizationStatusRestricted){
//            return NO;
//        }
//    }
//    return YES;
//}
//#pragma mark - 蓝牙权限
//+ (BOOL)authorizationForBlueTooth{
//    CBCentralManager *manager = [[CBCentralManager alloc] initWithDelegate:nil queue:nil];
//    switch (manager.state) {
//        case CBManagerStatePoweredOn:
//            return true;
//            break;
//        default:
//            return false;
//            break;
//    }
//    return false;
//}
//#pragma mark - 推送权限
//+ (BOOL)authorizationForNotification{
//    if (SYSTEMVERSION>=8.0f){
//        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
//        if (UIUserNotificationTypeNone == setting.types){
//            return NO;
//        }
//    }else{
//        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
//        if(UIRemoteNotificationTypeNone == type){
//            return NO;
//        }
//    }
//    return YES;
//}
//#pragma mark - 联网权限
//+ (BOOL)authorizationForNetWork{
//    CTCellularData *cellularData = [[CTCellularData alloc]init];
//    CTCellularDataRestrictedState state = cellularData.restrictedState;
//    if (state == kCTCellularDataRestricted) {
//        return NO;
//    }
//    return YES;
//}
//#pragma mark - 日历权限
//+ (BOOL)authorizationForCalendar{
//    EKAuthorizationStatus EKstatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
//    if (EKstatus == EKAuthorizationStatusDenied || EKstatus == EKAuthorizationStatusRestricted){
//        return NO;
//    }
//    return YES;
//}
//#pragma mark - 备忘录权限
//+ (BOOL)authorizationForReminder{
//    EKAuthorizationStatus EKstatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
//    if (EKstatus == EKAuthorizationStatusDenied || EKstatus == EKAuthorizationStatusRestricted){
//        return NO;
//    }
//    return YES;
//}
//
//
//
//+ (void)alertTitle:(NSString *)title description:(NSString *)description{
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//
//    NSString *tips = [NSString stringWithFormat:@"请在iPhone的“设置”中允许\"%@\"访问您的%@",app_Name,description];
//    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:tips preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self openUrl:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//    }];
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//    [alertVC addAction:action2];
//    [alertVC addAction:action];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
//}
//
//+(void)openUrl:(NSURL *)URL
//{
//    UIApplication *application = [UIApplication sharedApplication];
//    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
//        [application openURL:URL options:@{}
//           completionHandler:nil];
//    } else {
//        [application openURL:URL];
//    }
//}
//
//@end
//
