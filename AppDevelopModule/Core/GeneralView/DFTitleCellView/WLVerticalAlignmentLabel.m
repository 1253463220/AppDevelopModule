//
//  TextVerticalAlignmentLabel.m
//  DongfengWuliu
//
//  Created by 王立 on 2020/12/15.
//  Copyright © 2020 DongfengWuliu. All rights reserved.
//

#import "WLVerticalAlignmentLabel.h"

@implementation WLVerticalAlignmentLabel


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textVerticalAlignment = WLTextVerticalAlignmentTop;
    }
    return self;
}
 
- (void)setTextVerticalAlignment:(WLTextVerticalAlignment)textVerticalAlignment {
    _textVerticalAlignment = textVerticalAlignment;
    [self setNeedsDisplay];
}
 
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.textVerticalAlignment) {
        case WLTextVerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case WLTextVerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case WLTextVerticalAlignmentMiddle:
            
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}
 
-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
