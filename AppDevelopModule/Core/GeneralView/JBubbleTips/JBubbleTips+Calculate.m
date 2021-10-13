//
//  JBubbleTips+Calculate.m
//  JBubbleTips
//
//  Created by jams on 2019/4/8.
//  Copyright © 2019 jams. All rights reserved.
//

#import "JBubbleTips+Calculate.h"
#import "UIView+JUtils.h"
#import "objc/runtime.h"
@implementation JBubbleTips (Calculate)

#pragma mark - calculate method
- (CGPoint)convertView:(UIView *)targetView containerView:(UIView *)containerView {
    if (targetView == nil || containerView == nil) {
        return CGPointZero;
    }
    if (targetView.jb_width <= 0 || targetView.jb_height <= 0) {
        return CGPointZero;
    }
    if (containerView.jb_width <= 0 || containerView.jb_height <= 0) {
        return CGPointZero;
    }
    
    CGPoint originPoint = CGPointZero;
    switch (self.direction) {
        case JBubbleTipsDirectionUp:{
            originPoint = CGPointMake(targetView.jb_width / 2, targetView.jb_height);
        }
            break;
        case JBubbleTipsDirectionDown: {
            originPoint = CGPointMake(targetView.jb_width / 2, 0);
        }
            break;
        case JBubbleTipsDirectionLeft: {
            originPoint = CGPointMake(targetView.jb_width, targetView.jb_height / 2);
        }
            break;
        case JBubbleTipsDirectionRight: {
            originPoint = CGPointMake(0, targetView.jb_height / 2);
        }
            break;
    }
    return [targetView convertPoint:originPoint toView:containerView];
}

- (CGSize)bubbleSizeWithTargetPoint:(CGPoint)targetPoint inContainerView:(UIView *)containerView {
    CGSize bubbleSize = CGSizeZero;
    switch (self.style) {
        case JBubbleTipsStyleText:{
            CGFloat maxContentWidth,maxContentHeight;
            switch (self.direction) {
                case JBubbleTipsDirectionUp:{
                    maxContentWidth = containerView.jb_width - 2 * self.config.slidePadding - self.config.bubbleContentInsets.left - self.config.bubbleContentInsets.right;
                    maxContentHeight = containerView.jb_height - targetPoint.y - self.config.pointerSize - self.config.pointerMargin - self.config.bubbleContentInsets.top - self.config.bubbleContentInsets.bottom;
                }
                    break;
                case JBubbleTipsDirectionDown: {
                    maxContentWidth = containerView.jb_width - 2 *self.config.slidePadding - self.config.bubbleContentInsets.left - self.config.bubbleContentInsets.right;
                    maxContentHeight = targetPoint.y - self.config.pointerSize - self.config.pointerMargin - self.config.bubbleContentInsets.top - self.config.bubbleContentInsets.bottom;
                }
                    break;
                case JBubbleTipsDirectionLeft: {
                    maxContentWidth = containerView.jb_width - targetPoint.x - self.config.slidePadding - self.config.pointerSize - self.config.pointerMargin - self.config.bubbleContentInsets.left - self.config.bubbleContentInsets.right;
                    maxContentHeight = containerView.jb_height - 2 * self.config.slidePadding - self.config.bubbleContentInsets.top - self.config.bubbleContentInsets.bottom;
                }
                    break;
                case JBubbleTipsDirectionRight: {
                    maxContentWidth = targetPoint.x - self.config.slidePadding - self.config.pointerSize - self.config.pointerMargin - self.config.bubbleContentInsets.left - self.config.bubbleContentInsets.right;
                    maxContentHeight = containerView.jb_height - 2 * self.config.slidePadding - self.config.bubbleContentInsets.top - self.config.bubbleContentInsets.bottom;
                }
                    break;
            }
            maxContentWidth = MIN(maxContentWidth, self.config.maxTextWidth);
            NSAttributedString *content = [self generateAttributedString];
            CGRect contentRect = [content boundingRectWithSize:CGSizeMake(maxContentWidth, maxContentHeight) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            CGFloat bubbleWidth = contentRect.size.width + self.config.bubbleContentInsets.left + self.config.bubbleContentInsets.right;
            CGFloat bubbleHeight = contentRect.size.height + self.config.bubbleContentInsets.top + self.config.bubbleContentInsets.bottom;
            bubbleSize = CGSizeMake(bubbleWidth, bubbleHeight);
        }
            break;
            
        case JBubbleTipsStyleCustom:
            if (self.customView && self.customView.jb_width != 0 && self.customView.jb_height != 0) {
                CGFloat width = self.customView.jb_width + self.config.bubbleContentInsets.left + self.config.bubbleContentInsets.right;
                CGFloat height = self.customView.jb_height + self.config.bubbleContentInsets.top + self.config.bubbleContentInsets.bottom;
                bubbleSize = CGSizeMake(width, height);
            }
            break;
    }
    return bubbleSize;
}

- (NSAttributedString *)generateAttributedString {
    if (self.attributedString) {
        return [self.attributedString copy];
    } else {
        NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle alloc] init];
        textStyle.alignment = self.config.textAlignment;
        textStyle.lineSpacing = self.config.lineSpacing;
        NSDictionary *attributes = @{NSFontAttributeName : self.config.textFont, NSForegroundColorAttributeName : self.config.textColor, NSParagraphStyleAttributeName : textStyle};
            
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:self.text];
        [content addAttributes:attributes range:NSMakeRange(0, self.text.length)];
        return [content copy];
    }
}

- (CGRect)bubbleFrameWithTargetPoint:(CGPoint)targetPoint inContainerView:(UIView *)containerView {
    CGRect bubbleFrame;
    CGFloat pointerX = targetPoint.x;
    CGFloat pointerY = targetPoint.y;
    switch (self.direction) {
        case JBubbleTipsDirectionUp:
        case JBubbleTipsDirectionDown:{
            CGFloat x_begin = pointerX - roundf(self.bubbleSize.width / 2);
            if (x_begin < self.config.slidePadding) {
                x_begin = self.config.slidePadding;
            }
            if (x_begin + self.bubbleSize.width + self.config.slidePadding > containerView.jb_width) {
                x_begin = containerView.jb_width - self.bubbleSize.width - self.config.slidePadding;
            }
            
            CGFloat x_pointer = pointerX;
            if (x_pointer - self.config.pointerSize - self.config.cornerRadius < x_begin) {
                x_pointer = x_begin + self.config.pointerSize + self.config.cornerRadius;
            }
            if (x_pointer + self.config.pointerSize + self.config.cornerRadius > x_begin + self.bubbleSize.width) {
                x_pointer = x_begin + self.bubbleSize.width - self.config.pointerSize - self.config.cornerRadius;
            }
            CGFloat fullHeight = self.bubbleSize.height + self.config.pointerSize;
            CGFloat y_begin;
            CGPoint arrowPoint;
            if (self.direction == JBubbleTipsDirectionUp) {
                y_begin = pointerY + self.config.pointerMargin;
                arrowPoint = CGPointMake(x_pointer - x_begin, 0);
            } else {
                y_begin = pointerY - fullHeight - self.config.pointerMargin;
                arrowPoint = CGPointMake(x_pointer - x_begin, fullHeight);
            }
            self.arrowPoint = arrowPoint;
            bubbleFrame = CGRectMake(x_begin + self.config.pointerOffset.x, y_begin + self.config.pointerOffset.y, self.bubbleSize.width, fullHeight);
        }
            break;
            
        case JBubbleTipsDirectionLeft:
        case JBubbleTipsDirectionRight: {
            CGFloat y_begin = pointerY - roundf(self.bubbleSize.height / 2);
            if (y_begin < self.config.slidePadding) {
                y_begin = self.config.slidePadding;
            }
            if (y_begin + self.bubbleSize.height + self.config.slidePadding > containerView.jb_height) {
                y_begin = containerView.jb_height - self.config.slidePadding - self.bubbleSize.height;
            }
            
            CGFloat y_pointer = pointerY;
            if (y_pointer - self.config.pointerSize - self.config.cornerRadius < y_begin) {
                y_pointer = y_begin + self.config.pointerSize + self.config.cornerRadius;
            }
            if (y_pointer + self.config.pointerSize + self.config.cornerRadius > y_begin + self.bubbleSize.height) {
                y_pointer = y_begin + self.bubbleSize.height - self.config.pointerSize - self.config.cornerRadius;
            }
            
            CGFloat fullWidth = self.bubbleSize.width + self.config.pointerSize;
            CGFloat x_begin;
            CGPoint arrowPoint;
            if (self.direction == JBubbleTipsDirectionLeft) {
                x_begin = pointerX + self.config.pointerMargin;
                arrowPoint = CGPointMake(0, y_pointer - y_begin);
            } else {
                x_begin = pointerX - self.config.pointerMargin - fullWidth;
                arrowPoint = CGPointMake(fullWidth, y_pointer - y_begin);
            }
            self.arrowPoint = arrowPoint;
            bubbleFrame = CGRectMake(x_begin + self.config.pointerOffset.x, y_begin + self.config.pointerOffset.y, fullWidth, self.bubbleSize.height);
        }
            break;
    }
    return bubbleFrame;
}

@end
