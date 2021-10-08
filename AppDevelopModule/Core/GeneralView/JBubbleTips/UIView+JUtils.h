//
//  UIView+JUtils.h
//  JBubbleTips
//
//  Created by jams on 2019/4/8.
//  Copyright © 2019 jams. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JUtils)

- (CGFloat)jb_x;
- (void)setJb_x:(CGFloat)x;

- (CGFloat)jb_y;
- (void)setJb_Y:(CGFloat)y;

- (CGFloat)jb_width;
- (void)setJb_width:(CGFloat)width;

- (CGFloat)jb_height;
- (void)setJb_height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
