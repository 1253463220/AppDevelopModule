//
//  UIView+JUtils.m
//  JBubbleTips
//
//  Created by jams on 2019/4/8.
//  Copyright © 2019 jams. All rights reserved.
//

#import "UIView+JUtils.h"

@implementation UIView (JUtils)

- (CGFloat)jb_x{
    return self.frame.origin.x;
}

- (void)setJb_x:(CGFloat)x{
    self.frame = CGRectMake(x, self.jb_y, self.jb_width, self.jb_height);
}

- (CGFloat)jb_y{
    return self.frame.origin.y;
}

- (void)setJb_Y:(CGFloat)y{
    self.frame = CGRectMake(self.jb_x, y, self.jb_width, self.jb_height);
}

- (CGFloat)jb_width{
    return self.frame.size.width;
}

- (void)setJb_width:(CGFloat)width{
    self.frame = CGRectMake(self.jb_x, self.jb_y, width, self.jb_height);
}

- (CGFloat)jb_height{
    return self.frame.size.height;
}

- (void)setJb_height:(CGFloat)height{
    self.frame = CGRectMake(self.jb_x, self.jb_y, self.jb_width, height);
}

@end
