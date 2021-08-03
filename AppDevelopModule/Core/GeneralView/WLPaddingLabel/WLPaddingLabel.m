//
//  WLPaddingLabel.m
//  yunchaodan
//
//  Created by 王立 on 2021/7/8.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

#import "WLPaddingLabel.h"

@implementation WLPaddingLabel

-(void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.contentInsets)];
}

@end


