//
//  ApplicationManager.m
//  MiniApp
//
//  Created by 王立 on 2017/4/2.
//  Copyright © 2017年 王立. All rights reserved.
//

#import "ApplicationManager.h"
#import <sys/utsname.h>
#import <AVFoundation/AVFoundation.h>
@implementation ApplicationManager

+(instancetype)sharedApplicationManager
{
    static ApplicationManager *a = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        a = [[ApplicationManager alloc] init];
    });
    return a;
}

#pragma mark - app名字
+(NSString *)displayName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return app_Name;
}
#pragma mark - app版本
+(NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_version;
}
#pragma mark - 禁止休眠
+(void)forbidMobileSleep
{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}
#pragma mark - 打开手电筒
+(void)flashlight:(BOOL)forOpen{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) { // 判断是否有闪光灯
            // 请求独占访问硬件设备
            [device lockForConfiguration:nil];
            if (forOpen) {
                [device setTorchMode:AVCaptureTorchModeOn]; // 手电筒开
            }else{
                [device setTorchMode:AVCaptureTorchModeOff]; // 手电筒关
            }
            // 请求解除独占访问硬件设备
            [device unlockForConfiguration];
        }
    }
}
#pragma mark - 动画切换根视图
+(void)exchangeAppRootVC:(UIViewController *)newVC WithAnimation:(UIViewAnimationOptions)animationType
{
    // options是动画选项
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5f options:animationType animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = newVC;
        [UIView setAnimationsEnabled:oldState];
    } completion:^(BOOL finished) {
        
    }];
}

+(void)openUrl:(NSURL *)URL
{
    UIApplication *application = [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        
        //[application openURL:URL] ;
        if (@available(iOS 10.0, *)) {
            [application openURL:URL options:@{} completionHandler:nil];
        } else {
            [application openURL:URL];
        }
    } else {
        [application openURL:URL];
    }
}

#pragma mark - 去手机设置界面
+(void)gotoAppSet
{
    if (UIApplicationOpenSettingsURLString != NULL) {
        //  UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [self openUrl:URL];
    }
}
#pragma mark - 打电话
+(void)callPhone:(NSString *)phoneNum
{
    NSString *phoneStr = [@"tel://" stringByAppendingString:phoneNum];
    NSURL *url = [NSURL URLWithString:phoneStr];
    if (url) {
        
        [self openUrl:url];
    }
}

+(void)openSafariWithStr:(NSString *)str
{
    if (![str containsString:@"http"]) {
        return;
    }
    NSURL *url = [NSURL URLWithString:str];
    if (url) {
        [self openUrl:url];
    }
}

+(void)openUrlWithStr:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    if (url) {
        [self openUrl:url];
    }
}

#pragma mark - 获取手机型号
+(NSString *)getDeviceInfo {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    return platform;
}

#pragma mark - 删除NSUserDefaults所有记录
+(void)removeAllUserDefaults
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

#pragma mark - 获取当前控制器
+ (UIViewController *)currentVC{
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

#pragma mark - 获取keyWindow
+ (UIWindow *)keyWindow{
    __block UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [[UIApplication sharedApplication].windows.reverseObjectEnumerator.allObjects enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isMemberOfClass:[UIWindow class]] && obj.isKeyWindow) {
            keyWindow = obj;
            *stop = true;
        }
    }];
    return keyWindow;
}

#pragma mark - 获取最上层UIWindow
+ (UIWindow *)topWindow{
    __block UIWindow *topWindow = [UIApplication sharedApplication].keyWindow;
    [[UIApplication sharedApplication].windows.reverseObjectEnumerator.allObjects enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isMemberOfClass:[UIWindow class]]) {
            topWindow = obj;
            *stop = true;
        }
    }];
    return topWindow;
}

#pragma mark - 生成二维码
+ (UIImage *)generateQRCode:(NSString *)dataStr size:(CGSize)size{
    // 1.创建过滤器 -- 苹果没有将这个字符封装成常量
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.过滤器恢复默认设置
    [filter setDefaults];
    // 3.给过滤器添加数据(正则表达式/帐号和密码) -- 通过KVC设置过滤器,只能设置NSData类型
    NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    return [ApplicationManager createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGSize)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
@end
