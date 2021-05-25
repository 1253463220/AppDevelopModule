//
//  TestVC.m
//  AppDevelopExample
//
//  Created by 王立 on 2021/5/14.
//  Copyright © 2021 王立. All rights reserved.
//

#import "TestVC.h"
#import "AppDevelopExample-Swift.h"
#import <AppDevelopModule/AppDevelopModule-Swift.h>

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"adsfff"];
    str = [str color:[UIColor redColor]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 50)];
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label];
    label.attributedText = str;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
