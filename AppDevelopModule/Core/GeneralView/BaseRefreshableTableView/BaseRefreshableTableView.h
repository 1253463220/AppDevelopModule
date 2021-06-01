////
////  BaseRefreshableTableView.h
////  DongfengWuliu
////
////  Created by 王立 on 2021/1/28.
////  Copyright © 2021 DongfengWuliu. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//
//NS_ASSUME_NONNULL_BEGIN
//
//typedef NSInteger PageIndex;
//typedef NSInteger PageSize;
//typedef id _Nullable (^RefreshRequstAct)(PageIndex currentIndex,PageSize pageSize); //返回值为YXRouter对象
//typedef NSInteger (^RefreshGetDataAct)(NSDictionary * _Nonnull result);
//
//@interface BaseRefreshableTableView : UITableView
//
//- (void)enableRefreshWithRequstAct:(RefreshRequstAct)requstAct refreshAct:(RefreshGetDataAct)refreshAct loadMoreAct:(RefreshGetDataAct)loadMoreAct originalPageIndex:(NSInteger)originalPageIndex pageSize:(NSInteger)pageSize emptyView:(UIView * _Nullable)emptyView emptyOffsetY:(CGFloat)emptyOffsetY;
//
//- (void)addRefreshHeaderWithRequstAct:(RefreshRequstAct)requstAct refreshAct:(RefreshGetDataAct)refreshAct emptyView:(UIView * _Nullable)emptyView emptyOffsetY:(CGFloat)emptyOffsetY;
//
//@end
//
//NS_ASSUME_NONNULL_END
