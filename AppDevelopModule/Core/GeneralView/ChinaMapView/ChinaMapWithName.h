//
//  ChinaMapWithName.h
//  TestWebView
//
//  Created by apple on 17/1/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChinaMapWithName : UIView

@property (nonatomic,assign) NSUInteger seletedIdx;//选中的地图块
@property (copy, nonatomic) void (^tapMapAct)(NSString* provinceName,CGPoint point);
@property (copy, nonatomic) void (^touchEmptyAct)(void);
@property (nonatomic,strong) NSMutableArray <NSDictionary *>*textArr;// 各个省级行政区名字及位置数组

- (void)configColorArr:(NSArray <UIColor *>*)colorArr;

@property (assign, nonatomic) CGAffineTransform baseTransform;
@end
