//
//  DFTitleCellConfigModel.h
//  DongfengWuliu
//
//  Created by 王立 on 2020/11/30.
//  Copyright © 2020 DongfengWuliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLVerticalAlignmentLabel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    DFRightViewTypeOnlyTitle,
    DFRightViewTypeLabel,
    DFRightViewTypeImage,
    DFRightViewTypeTextField,
    DFRightViewTypeOffOn,
    DFRightViewTypeCustomView,
} DFRightViewType;

@interface DFTitleCellConfigModel : NSObject
/**标题*/
@property (copy, nonatomic) NSString *title;
/**右边label文字（如果有右部label）*/
@property (copy, nonatomic) NSString *r_valueStr;
/**右部样式*/
@property (assign, nonatomic) DFRightViewType rightType;
/**右部的自定义视图*/
@property (strong, nonatomic) UIView *customRightView;
/**整体高度*/
@property (assign, nonatomic) CGFloat itemHeight;
/**左右内边距*/
@property (assign, nonatomic) UIEdgeInsets contentEdgeInset;
/**底线位置,top无效*/
@property (assign, nonatomic) UIEdgeInsets lineEdgeInset;
/**左stackView宽度*/
@property (assign, nonatomic) CGFloat leftStackWidth;
/**左右stackView间距*/
@property (assign, nonatomic) CGFloat baseStackSpace;
/**整体背景色*/
@property (strong, nonatomic, nullable) UIColor *backColor;
/**点击事件*/
@property (copy, nonatomic) void (^tapBlock)(void);



/**是否显示*  */
@property (assign, nonatomic) BOOL isShowStar;
/**是否显示左边图片  */
@property (assign, nonatomic) BOOL isShowTitleImg;
/**titleimg右边的margin  */
@property (assign, nonatomic) float titleImgRightMargin;
/**titleimg的大小  */
@property (assign, nonatomic) CGSize titleImgSize;
/**titleimg*/
@property (strong, nonatomic) UIImage *titleImg;
/**是否有右箭头*/
@property (assign, nonatomic) BOOL isShowRightArrow;
/**箭头图片*/
@property (strong, nonatomic) UIImage *arrowImg;

/**是否有下底线*/
@property (assign, nonatomic) BOOL isShowLine;
/**下底线高度*/
@property (assign, nonatomic) BOOL lineHeight;
/**线条颜色*/
@property (strong, nonatomic, nullable) UIColor *lineColor;



/**左标题颜色*/
@property (strong, nonatomic, nullable) UIColor *titleLabelColor;
/**左标题文字大小*/
@property (strong, nonatomic, nullable) UIFont *titleLabelFont;
/**右label颜色*/
@property (strong, nonatomic, nullable) UIColor *valueLabelColor;
/**右label文字大小*/
@property (strong, nonatomic, nullable) UIFont *valueLabelFont;
/**左标题文字垂直位置*/
@property (assign, nonatomic) WLTextVerticalAlignment leftTextVerticalAlignment;
/**是否按下改变背景色*/
@property (assign, nonatomic) bool shouldPressColor;

@end

NS_ASSUME_NONNULL_END
