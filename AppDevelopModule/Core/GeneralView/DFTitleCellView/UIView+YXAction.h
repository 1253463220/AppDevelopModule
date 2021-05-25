//
//  UIControl+YXAction.h
//  ClouderWork-iOS
//
//  Created by 秋名山滑板少年 on 2019/5/4.
//  Copyright © 2019 https://www.clouderwork.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YXAction)

- (void)addTapAction:(void(^)(UITapGestureRecognizer *sender))handler;
- (void)addLongPressAction:(void (^)(UILongPressGestureRecognizer *))handler;

@end
