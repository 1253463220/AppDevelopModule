//
//  UIView+NDViewFrame.m
//  NDTruck
//
//  Created by 王立 on 2019/11/4.
//  Copyright © 2019 k_yan. All rights reserved.
//

#import "UIView+NDViewFrame.h"

@implementation UIView (NDViewFrame)

-(void)setNd_x:(CGFloat)nd_x{
    CGRect frame = self.frame;
    frame.origin.x = nd_x;
    self.frame = frame;
}

-(CGFloat)nd_x{
    return CGRectGetMinX(self.frame);
}

-(void)setNd_y:(CGFloat)nd_y{
    CGRect frame = self.frame;
    frame.origin.y = nd_y;
    self.frame = frame;
}

-(CGFloat)nd_y{
    return CGRectGetMinY(self.frame);
}

-(void)setNd_width:(CGFloat)nd_width{
    CGRect frame = self.frame;
    frame.size.width = nd_width;
    self.frame = frame;
}

-(CGFloat)nd_width{
    return CGRectGetWidth(self.frame);
}

-(void)setNd_height:(CGFloat)nd_height{
    CGRect frame = self.frame;
    frame.size.height = nd_height;
    self.frame = frame;
}

-(CGFloat)nd_height{
    return CGRectGetHeight(self.frame);
}

-(void)setNd_maxY:(CGFloat)nd_maxY{
    self.nd_y = nd_maxY - self.nd_height;
}

-(CGFloat)nd_maxY{
    return CGRectGetMaxY(self.frame);
}

-(void)setNd_maxX:(CGFloat)nd_maxX{
    self.nd_x = nd_maxX - self.nd_width;
}

-(CGFloat)nd_maxX{
    return CGRectGetMaxX(self.frame);
}

-(void)setNd_centerX:(CGFloat)nd_centerX{
    CGPoint center = self.center;
    center.x = nd_centerX;
    self.center = center;
}

- (CGFloat)nd_centerX{
    return self.center.x;
}

-(void)setNd_centerY:(CGFloat)nd_centerY{
    CGPoint center = self.center;
    center.y = nd_centerY;
    self.center = center;
}

-(CGFloat)nd_centerY{
    return self.center.y;
}

-(void)setNd_size:(CGSize)nd_size{
    CGRect frame = self.frame;
    frame.size = nd_size;
    self.frame = frame;
}

-(CGSize)nd_size{
    return self.frame.size;
}

@end
