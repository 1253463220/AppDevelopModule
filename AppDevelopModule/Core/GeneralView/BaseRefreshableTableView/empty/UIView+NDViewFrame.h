//
//  UIView+NDViewFrame.h
//  NDTruck
//
//  Created by 王立 on 2019/11/4.
//  Copyright © 2019 k_yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (NDViewFrame)

@property (nonatomic,assign)CGFloat nd_x;
@property (nonatomic,assign)CGFloat nd_y;
@property (nonatomic,assign)CGFloat nd_width;
@property (nonatomic,assign)CGFloat nd_height;
@property (nonatomic,assign)CGFloat nd_centerX;
@property (nonatomic,assign)CGFloat nd_centerY;
@property (nonatomic,assign)CGFloat nd_maxY;
@property (nonatomic,assign)CGFloat nd_maxX;
@property (nonatomic,assign)CGSize nd_size;


@end

NS_ASSUME_NONNULL_END
