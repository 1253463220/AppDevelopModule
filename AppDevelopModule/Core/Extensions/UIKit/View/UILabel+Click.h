//
//  UILabel+Click.h
//  FriendCircle
//
//  Created by xgf on 2018/8/16.
//  Copyright © 2018年 HuaZhongShiXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Click)

- (void)clearHandler;
/**
 * 处理UILabel的text的某个range的点击事件
 * clickRange UILabel的text的响应点击事件的范围
 * handler 点击给定范围内的字符串的回调
 */
- (void)clickAtRange:(NSRange)clickRange handler:(void(^)(UILabel *, UITapGestureRecognizer *))handler;

@end

@interface UITextView (Click)

- (void)clearHandler;

- (void)clickAtRange:(NSRange)clickRange handler:(void(^)(UITextView *, UITapGestureRecognizer *))handler;

@end
