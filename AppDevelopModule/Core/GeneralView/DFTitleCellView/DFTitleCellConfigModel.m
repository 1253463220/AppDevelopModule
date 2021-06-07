//
//  DFTitleCellConfigModel.m
//  DongfengWuliu
//
//  Created by 王立 on 2020/11/30.
//  Copyright © 2020 DongfengWuliu. All rights reserved.
//

#import "DFTitleCellConfigModel.h"

@implementation DFTitleCellConfigModel

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
    self.rightType = DFRightViewTypeLabel;
    self.isShowLine = true;
    self.leftTextVerticalAlignment = WLTextVerticalAlignmentMiddle;
    self.baseStackSpace = 10;
    self.titleImgRightMargin = 5;
    self.lineHeight = 0.5;
    self.titleImgSize = CGSizeZero;
    self.contentEdgeInset = UIEdgeInsetsMake(0, 16, 0, 16);
}

@end
