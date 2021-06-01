//
//  UIView+NDEmpty.h
//  NDTruck
//
//  Created by 王立 on 2019/12/3.
//  Copyright © 2019 k_yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (NDEmpty)

/*empty view*/
@property (nonatomic,strong,nullable) UIView *nd_emptyView;

@property (nonatomic, assign) CGFloat emptyOffsetY;

-(void)nd_hideEmptyView;

-(void)nd_ShowEmptyView;

@end

NS_ASSUME_NONNULL_END
