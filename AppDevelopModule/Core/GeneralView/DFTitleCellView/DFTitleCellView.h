//
//  DFTitleCellView.h
//  DongfengWuliu
//
//  Created by 王立 on 2020/11/30.
//  Copyright © 2020 DongfengWuliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFTitleCellConfigModel.h"
#import "WLVerticalAlignmentLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFTitleCellView : UIView

@property (strong, nonatomic, nullable) UIView *backV;

@property (strong, nonatomic, nullable) UIImageView *l_titleImgV;
@property (strong, nonatomic, nullable) WLVerticalAlignmentLabel *l_starL;
@property (strong, nonatomic, nullable) WLVerticalAlignmentLabel *l_titleL;

@property (strong, nonatomic, nullable) UILabel *r_valueL;
@property (strong, nonatomic, nullable) UIImageView *r_imageV;
@property (strong, nonatomic, nullable) UITextField *r_textTF;
@property (strong, nonatomic, nullable) UIImageView *r_arrowImgV;
@property (strong, nonatomic, nullable) UISwitch *r_swithcV;

@property (strong, nonatomic, nullable) UIView *lineV;

@property (strong, nonatomic) DFTitleCellConfigModel *config;

- (instancetype)initWithConfig:(DFTitleCellConfigModel *)config;

+ (UIStackView *)createVerticalStackViewWith:(NSArray <DFTitleCellConfigModel*>*)configs enumerateBlock:(void (NS_NOESCAPE ^)(DFTitleCellView *cellView,DFTitleCellConfigModel *config, NSUInteger idx))enumerateBlock;

@end

NS_ASSUME_NONNULL_END
