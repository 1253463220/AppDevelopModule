//
//  NDHeader.h
//  yunchaodan
//
//  Created by 王立 on 2021/5/17.
//  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
//

#ifndef NDHeader_h
#define NDHeader_h

//坐标
#define NDWindowView [UIApplication sharedApplication].keyWindow
#define NDSCREENBOUNS  [UIScreen mainScreen].bounds
#define NDSCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define NDSCREENHEIGHT  [UIScreen mainScreen].bounds.size.height
#define NDSCREENSCALE  [UIScreen mainScreen].scale

#define NDISNORNALSCREEN  (NDSCREENHEIGHT < 800)
#define NDSAFEBOTTOM  (NDISNORNALSCREEN ? 0 : 34)
#define NDTOPBARHEIGTH  [[UIApplication sharedApplication] statusBarFrame].size.height
#define NDNAVIHEIGHT  (44 + NDTOPBARHEIGTH)
#define NDTABBARHEIGHT  (NDISNORNALSCREEN ? 49 : (49 + NDSAFEBOTTOM))

#define NDHORIZONFIT(x) ((x) * NDSCREENWIDTH / 375.0)
#define NDVERTICALFIT(y) ((y) * NDSCREENHEIGHT / 667.0)

//rbg转UIColor(16进制)
#define NDRGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1]
#define NDRGB16_WITH_ALPHA_COMPONENT(rgbValue, alpha) [NDRGB16(rgbValue) colorWithAlphaComponent:alpha]
#define NDRGBAColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a) / 1.0]
#define NDRGBColor(r, g, b) NDRGBAColor((r), (g), (b), 1.0)
#define NDRGBWhiteColor(white, a) [UIColor colorWithWhite:(white) alpha:(a)]
#define NDRandomColor NDRGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#import "UIView+NDViewFrame.h"

#endif /* NDHeader_h */
