//
//  TextVerticalAlignmentLabel.h
//  DongfengWuliu
//
//  Created by 王立 on 2020/12/15.
//  Copyright © 2020 DongfengWuliu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,WLTextVerticalAlignment){
    //当文字是单行的时候，文字是居上的而不是默认的居中，解决Label与上面控件的间距扩大的问题
    WLTextVerticalAlignmentMiddle = 1,
    WLTextVerticalAlignmentTop,
    WLTextVerticalAlignmentBottom,
};

@interface WLVerticalAlignmentLabel : UILabel

@property (nonatomic) WLTextVerticalAlignment textVerticalAlignment;

@end

NS_ASSUME_NONNULL_END
