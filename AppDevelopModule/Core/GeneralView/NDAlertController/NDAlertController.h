//
//  SCAlertController.h
//  MCall
//
//  Created by 代军 on 2017/3/7.
//  Copyright © 2017年 kmw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDAlertAction : UIAlertAction

@property (nonatomic,strong) UIColor *textColor; /**< 按钮title字体颜色 */

@end

@interface NDAlertController : UIAlertController

@property (nonatomic,strong) UIColor *tintColor; /**< 统一按钮样式 不写系统默认的蓝色 */
@property (nonatomic,strong) UIColor *titleColor; /**< 标题的颜色 */
@property (nonatomic,strong) UIColor *messageColor; /**< 信息的颜色 */

- (void)alertTapDismiss;

@end
