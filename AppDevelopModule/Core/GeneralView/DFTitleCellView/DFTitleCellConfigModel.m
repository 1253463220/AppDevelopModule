//
//  DFTitleCellConfigModel.m
//  DongfengWuliu
//
//  Created by 王立 on 2020/11/30.
//  Copyright © 2020 DongfengWuliu. All rights reserved.
//

#import "DFTitleCellConfigModel.h"

@implementation DFTitleCellConfigModel

- (instancetype)initWith:(NSString *)title type:(RightViewType)type itemHeight:(CGFloat)itemHeight horizPadding:(CGFloat)horizPadding verticalPadding:(CGFloat)verticalPadding leftStackWidth:(CGFloat)leftStackWidth baseStackSpace:(CGFloat)baseStackSpace{
    if (self = [super init]) {
        [self baseInit];
        self.title = title;
        self.type = type;
        self.itemHeight = itemHeight;
        self.horizPadding = horizPadding;
        self.verticalPadding = verticalPadding;
        self.leftStackWidth = leftStackWidth;
        self.baseStackSpace = baseStackSpace;
    }
    return  self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit{
    self.title = @"";
    self.type = RightViewTypeLabel;
    self.isShowStar = false;
    self.isShowArrow = false;
    self.isCanTap = false;
    self.isShowLine = true;
    self.leftTextVerticalAlignment = WLTextVerticalAlignmentMiddle;
    self.baseStackSpace = 10;
}

@end
