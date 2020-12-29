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
    RightViewTypeOnlyTitle,
    RightViewTypeLabel,
    RightViewTypeImage,
    RightViewTypeTextField,
    RightViewTypeOffOn,
    RightViewTypeCustomView,
} RightViewType;

@interface DFTitleCellConfigModel : NSObject
/**标题*/
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) RightViewType type;
/**是否显示*  */
@property (assign, nonatomic) BOOL isShowStar;
/**是否有右箭头*/
@property (assign, nonatomic) BOOL isShowArrow;
/**是否有下划线*/
@property (assign, nonatomic) BOOL isShowLine;
/**右部的自定义视图*/
@property (strong, nonatomic) UIView *customView;
/**整体高度*/
@property (assign, nonatomic) CGFloat itemHeight;
/**左右内边距*/
@property (assign, nonatomic) CGFloat horizPadding;
/**上下内边距*/
@property (assign, nonatomic) CGFloat verticalPadding;
/**是否可点击*/
@property (assign, nonatomic) BOOL isCanTap;
/**点击事件*/
@property (copy, nonatomic) void (^tapBlock)(void);

- (instancetype)initWith:(NSString *)title type:(RightViewType)type itemHeight:(CGFloat)itemHeight horizPadding:(CGFloat)horizPadding verticalPadding:(CGFloat)verticalPadding leftStackWidth:(CGFloat)leftStackWidth baseStackSpace:(CGFloat)baseStackSpace;

/**左stackView宽度*/
@property (assign, nonatomic) CGFloat leftStackWidth;
/**左右右stackView间距*/
@property (assign, nonatomic) CGFloat baseStackSpace;
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
/**整体背景色*/
@property (strong, nonatomic, nullable) UIColor *backColor;
/**左标题文字垂直位置*/
@property (assign, nonatomic) WLTextVerticalAlignment leftTextVerticalAlignment;

@end

NS_ASSUME_NONNULL_END
