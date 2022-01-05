////
////  WLMenuView.h
////  DemoSDK
////
////  Created by 王立 on 2021/12/27.
////  Copyright © 2021 tdx.com.iPhone. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//
//NS_ASSUME_NONNULL_BEGIN
//
//
//@interface WLScroContentView : UIView
//
//@property (strong, nonatomic, readonly) UIScrollView *scroV;
//@property (strong, nonatomic, readonly) UIView *baseV;
//@property (strong, nonatomic, readonly) UIView *contentV;
//@property (assign, nonatomic) UIEdgeInsets contentEdge;
//@property (assign, nonatomic) CGFloat itemSpace;
//@property (strong, nonatomic) NSArray <UIView*>*items;
//- (instancetype)initWithContentEdge:(UIEdgeInsets)contentEdge itemSpace:(CGFloat)itemSpace;
/////添加视图
//- (void)addContentViews:(NSArray<UIView*>*)views;
/////清空内容
//- (void)clearContent;
/////遍历内容
//- (void)enumItemsWith:(void (^)(NSUInteger index, UIView *itemV))enumBlock;
/////重新布局item
//- (void)reloadItemUI;
//
//@end
//
//
//
//@interface WLMenuItemView : UIButton
//
//typedef void(^UIConfig)(WLMenuItemView* itemV);
//@property (copy, nonatomic) UIConfig normalUIConfig;
//@property (copy, nonatomic) UIConfig selectUIconfig;
//- (instancetype)initWithNormalUIConfig:(UIConfig)normalUIConfig selectUIConfig:(UIConfig)selectUIconfig;
//
//@end
//
//
//@interface WLMenuView : WLScroContentView
//
//typedef UIView *_Nullable(^IndicatorUIConfigAct)(NSInteger selectIndex,WLMenuItemView *selectItemV,WLMenuView *menuV);
//typedef void(^IndicatorIndexChangeAct)(NSInteger selectIndex,WLMenuItemView *selectItemV,WLMenuView *menuV,UIView *indicatorV);
//typedef BOOL(^IndexWillChangeAct)(NSInteger index,WLMenuItemView *itemV);
//typedef void(^IndexDidChangeAct)(NSInteger index,WLMenuItemView *itemV);
//
//@property (assign, nonatomic,readonly) NSInteger defaultIndex;
//@property (assign, nonatomic,readonly) NSInteger selectedIndex;
//@property (copy, nonatomic) IndexWillChangeAct indexWillChanged;
//@property (copy, nonatomic) IndexDidChangeAct indexDidChanged;
//@property (assign, nonatomic) BOOL shouldAutoCenter;
//- (instancetype)initWithItemArr:(NSArray <WLMenuItemView*>*)itemArr defaultSelectedIndex:(NSInteger)defaultSelectedIndex itemSpace:(CGFloat)itemSpace;
//- (void)updateUI;
//- (void)updateMenuItems:(NSArray<WLMenuItemView*>*)itemArr defaultSelectIndex:(NSInteger)defaultSelectIndex;
//- (void)configIndicator:(IndicatorUIConfigAct)configAct indexChangeAct:(IndicatorIndexChangeAct)indexChangeAct;
//- (void)gotIndexWithoutAct:(NSInteger)index;
//- (void)gotoIndex:(NSInteger)index animated:(BOOL)animated shouldPerfomAct:(BOOL)shouldPerfomAct;
//
//
//@end
//
//NS_ASSUME_NONNULL_END
