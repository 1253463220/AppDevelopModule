//
//  UIControl+YXAction.m
//  ClouderWork-iOS
//
//  Created by 秋名山滑板少年 on 2019/5/4.
//  Copyright © 2019 https://www.clouderwork.com. All rights reserved.
//


#import "UIView+YXAction.h"
#import <objc/runtime.h>

static char *UIViewYXTapActionHandlerKey="UIViewTapActionHandlerKey";
static char *UIViewYXLongPressActionHandlerKey="UIViewLongPressActionHandlerKey";

@implementation UIView (YXAction)

- (void)addTapAction:(void (^)(UITapGestureRecognizer *))handler {
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, UIViewYXTapActionHandlerKey, handler, OBJC_ASSOCIATION_COPY);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(x_tapAction:)];
    [self addGestureRecognizer:tap];
}

- (void)addLongPressAction:(void (^)(UILongPressGestureRecognizer *))handler {
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, UIViewYXLongPressActionHandlerKey, handler, OBJC_ASSOCIATION_COPY);
    UILongPressGestureRecognizer *lp = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(x_longPressAction:)];
    [self addGestureRecognizer:lp];
}

- (void)x_tapAction:(UITapGestureRecognizer *)sender {
    void(^handler)(UITapGestureRecognizer *)=objc_getAssociatedObject(self, UIViewYXTapActionHandlerKey);
    if(handler) {
        handler(sender);
    }
}

- (void)x_longPressAction:(UILongPressGestureRecognizer *)sender {
    void(^handler)(UILongPressGestureRecognizer *)=objc_getAssociatedObject(self, UIViewYXLongPressActionHandlerKey);
    if(handler) {
        handler(sender);
    }
}



@end
