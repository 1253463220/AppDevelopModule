//
//  DFImagePickerVCHelp.h
//  DongfengWuliu
//
//  Created by 吴志勇 on 2020/11/18.
//  Copyright © 2020 DongfengWuliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoTool : NSObject

+ (void)resizeVideoWithAsset:(AVURLAsset *)asset preferSize:(long long)preferSize doneHandler:(void(^)(NSURL *outputURL,NSError *error))doneHandler;

@end

NS_ASSUME_NONNULL_END
