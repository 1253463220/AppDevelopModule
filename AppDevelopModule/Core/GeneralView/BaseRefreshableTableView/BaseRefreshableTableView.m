////
////  BaseRefreshableTableView.m
////  DongfengWuliu
////
////  Created by 王立 on 2021/1/28.
////  Copyright © 2021 DongfengWuliu. All rights reserved.
////
//
//#import "BaseRefreshableTableView.h"
//#import <MJRefresh/MJRefresh.h>
//#import "UIView+NDEmpty.h"
//#import "YXNetwork.h"
//
//#define WEAKSELF typeof(self) __weak weakSelf = self;
//
//@interface BaseRefreshableTableView ()
//{
//    
//}
//@property (assign, nonatomic) NSInteger originalPageIndex;
//@property (assign, nonatomic) NSInteger pageIndex;
//@property (assign, nonatomic) NSInteger pageSize;
//
//
//@property (copy, nonatomic) RefreshRequstAct requstAct;
//@property (copy, nonatomic) RefreshGetDataAct refreshAct;
//@property (copy, nonatomic) RefreshGetDataAct loadMoreAct;
//
//@end
//
//@implementation BaseRefreshableTableView
//
//- (void)enableRefreshWithRequstAct:(RefreshRequstAct)requstAct refreshAct:(RefreshGetDataAct)refreshAct loadMoreAct:(RefreshGetDataAct)loadMoreAct originalPageIndex:(NSInteger)originalPageIndex pageSize:(NSInteger)pageSize emptyView:(UIView * _Nullable)emptyView emptyOffsetY:(CGFloat)emptyOffsetY{
//    self.requstAct = requstAct;
//    self.refreshAct = refreshAct;
//    self.loadMoreAct = loadMoreAct;
//    self.originalPageIndex = originalPageIndex;
//    self.pageSize = pageSize;
//    self.nd_emptyView = emptyView;
//    self.emptyOffsetY = emptyOffsetY;
//    if (emptyView != nil) {
//        [self nd_ShowEmptyView];
//    }
//    
//    self.mj_footer.hidden = true;
//    WEAKSELF
//    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        if (weakSelf.mj_footer.isRefreshing) {
//            [weakSelf.mj_header endRefreshing];
//            return;
//        }
//        weakSelf.pageIndex = weakSelf.originalPageIndex;
//        
//        id temp = weakSelf.requstAct(weakSelf.pageIndex,weakSelf.pageSize);
//        if (![temp isKindOfClass:[YXRouter class]]) {
//            return;
//        }
//        YXRouter *router = (YXRouter *)temp;
//        [YXNetwork request:router succes:^(NSDictionary * _Nonnull json) {
//            NSInteger dataCount = weakSelf.refreshAct(json);
//            [weakSelf.mj_header endRefreshing];
//            if (dataCount < weakSelf.pageSize) {
//                [weakSelf.mj_footer endRefreshingWithNoMoreData];
//            }else{
//                [weakSelf.mj_footer endRefreshing];
//            }
//            weakSelf.mj_footer.hidden = (dataCount == 0);
//            if (self.nd_emptyView != nil) {
//                if (dataCount > 0) {
//                    [self nd_hideEmptyView];
//                }else{
//                    [self nd_ShowEmptyView];
//                }
//            }
//            [self reloadData];
//        } failure:^(int code, NSError * _Nullable error) {
//            [weakSelf.mj_header endRefreshing];
//            [weakSelf.mj_footer endRefreshing];
//            HUDError(error.localizedDescription);
//        }];
//    }];
//
//    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        if (weakSelf.mj_header.isRefreshing) {
//            [weakSelf.mj_footer endRefreshing];
//            return;
//        }
//        weakSelf.pageIndex += 1;
//        
//        YXRouter *router = weakSelf.requstAct(weakSelf.pageIndex,weakSelf.pageSize);
//        [YXNetwork request:router succes:^(NSDictionary * _Nonnull json) {
//            NSInteger dataCount = weakSelf.loadMoreAct(json);
//            if (dataCount < weakSelf.pageSize) {
//                [weakSelf.mj_footer endRefreshingWithNoMoreData];
//            }else{
//                [weakSelf.mj_footer endRefreshing];
//            }
//            [self reloadData];
//        } failure:^(int code, NSError * _Nullable error) {
//            [weakSelf.mj_header endRefreshing];
//            [weakSelf.mj_footer endRefreshing];
//            HUDError(error.localizedDescription);
//        }];
//    }];
//}
//
//- (void)addRefreshHeaderWithRequstAct:(RefreshRequstAct)requstAct refreshAct:(RefreshGetDataAct)refreshAct emptyView:(UIView * _Nullable)emptyView emptyOffsetY:(CGFloat)emptyOffsetY{
//    self.requstAct = requstAct;
//    self.refreshAct = refreshAct;
//    self.nd_emptyView = emptyView;
//    self.emptyOffsetY = emptyOffsetY;
//    if (emptyView != nil) {
//        [self nd_ShowEmptyView];
//    }
//    
//    WEAKSELF
//    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        id temp = weakSelf.requstAct(weakSelf.pageIndex,weakSelf.pageSize);
//        if (![temp isKindOfClass:[YXRouter class]]) {
//            return;
//        }
//        YXRouter *router = (YXRouter *)temp;
//        [YXNetwork request:router succes:^(NSDictionary * _Nonnull json) {
//            NSInteger dataCount = weakSelf.refreshAct(json);
//            [weakSelf.mj_header endRefreshing];
//            if (self.nd_emptyView != nil) {
//                if (dataCount > 0) {
//                    [self nd_hideEmptyView];
//                }else{
//                    [self nd_ShowEmptyView];
//                }
//            }
//            [self reloadData];
//        } failure:^(int code, NSError * _Nullable error) {
//            [weakSelf.mj_header endRefreshing];
//            HUDError(error.localizedDescription);
//        }];
//    }];
//}
//
//@end
