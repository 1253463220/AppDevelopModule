//
//  UIView+NDEmpty.m
//  NDTruck
//
//  Created by 王立 on 2019/12/3.
//  Copyright © 2019 k_yan. All rights reserved.
//

#import "UIView+NDEmpty.h"
#import <objc/runtime.h>
#import "NDHeader.h"

@implementation UIView (NDEmpty)

char empty = 'e';
-(void)setNd_emptyView:(UIView *)nd_emptyView{
    if (nd_emptyView == self.nd_emptyView) { return; }
    [self.nd_emptyView removeFromSuperview];
    objc_setAssociatedObject(self, &empty, nd_emptyView, OBJC_ASSOCIATION_RETAIN);
    if (nd_emptyView != nil) {
        [self addSubview:nd_emptyView];
        nd_emptyView.hidden = YES;
    }
}

- (nullable UIView *)nd_emptyView{
    return objc_getAssociatedObject(self, &empty);
}

- (CGFloat)emptyOffsetY {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setEmptyOffsetY:(CGFloat )emptyOffsetY {
    objc_setAssociatedObject(self, @selector(emptyOffsetY), @(emptyOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)nd_hideEmptyView{
    self.nd_emptyView.hidden = YES;
}

-(void)nd_ShowEmptyView{
    [self.superview layoutIfNeeded];
    self.nd_emptyView.hidden = NO;
    self.nd_emptyView.nd_y = self.emptyOffsetY;
    self.nd_emptyView.nd_centerX = self.nd_width / 2;
}


@end
