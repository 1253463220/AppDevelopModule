//
//  ChinaMapView.h
//  Testing
//
//  Created by 王立 on 2021/9/21.
//  Copyright © 2021 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChinaMapWithName.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChinaMapView : UIView

@property (strong, nonatomic) ChinaMapWithName *contentV;
@property (strong, nonatomic) UIScrollView *scroV;

@property (copy, nonatomic) void (^hideMakerAct)(void);

@end

NS_ASSUME_NONNULL_END
