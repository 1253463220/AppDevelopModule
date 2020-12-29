//
//  MapGuideManager.h
//  DFVehicleSteward
//
//  Created by 王立 on 2018/4/27.
//  Copyright © 2018年 ssi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapGuideManager : NSObject
///传入高德gcj02坐标系坐标
+ (void)startMapGuide:(double)lat lon:(double)lon;

@end
