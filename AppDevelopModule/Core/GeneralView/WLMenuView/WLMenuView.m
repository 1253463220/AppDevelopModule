////
////  WLMenuView.m
////  DemoSDK
////
////  Created by 王立 on 2021/12/27.
////  Copyright © 2021 tdx.com.iPhone. All rights reserved.
////
//
//#import "WLMenuView.h"
//#import "Masonry.h"
//
//@interface WLScroContentView ()
//@property (strong, nonatomic, readwrite) UIScrollView *scroV;
//@property (strong, nonatomic, readwrite) UIView *baseV;
//@property (strong, nonatomic, readwrite) UIView *contentV;
//@property (strong, nonatomic) NSMutableArray <NSLayoutConstraint*>*edgeConstraints;
//@end
//@implementation WLScroContentView
//
//#pragma mark 生命周期
//- (instancetype)initWithContentEdge:(UIEdgeInsets)contentEdge itemSpace:(CGFloat)itemSpace{
//    self = [super initWithFrame:CGRectZero];
//    if (self) {
//        self.contentEdge = contentEdge;
//        self.itemSpace = itemSpace;
//        [self configUI];
//    }
//    return self;
//}
//
//#pragma mark 通知/KVO/setter
//
//#pragma mark 界面布局
//- (void)configUI{
//    [self addSubview:self.scroV];
//    [self.scroV addSubview:self.baseV];
//    [self.baseV addSubview:self.contentV];
//
//    self.scroV.backgroundColor = [UIColor redColor];
//    [self.scroV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//    [self.baseV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.scroV);
//        make.height.equalTo(self.scroV);
//    }];
//    [self.contentV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.baseV).insets(self.contentEdge);
//    }];
//}
//
//- (void)reloadItemUI{
//    [self.items enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [obj removeFromSuperview];
//    }];
//    __block UIView *laseItemV;
//    [self.items enumerateObjectsUsingBlock:^(UIView * _Nonnull itemV, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self.contentV addSubview:itemV];
//        [itemV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.equalTo(self.contentV);
//            if (laseItemV == nil) {
//                make.left.equalTo(self.contentV);
//            }else{
//                make.left.equalTo(laseItemV.mas_right).offset(self.itemSpace);
//            }
//            if (idx == self.items.count-1) {
//                make.right.equalTo(self.contentV);
//            }
//        }];
//        laseItemV = itemV;
//    }];
//}
//#pragma mark 数据请求
//
//#pragma mark 事件
//
//#pragma mark 逻辑
//- (void)addContentViews:(NSArray<UIView*>*)views{
//    [(NSMutableArray *)self.items addObjectsFromArray:views];
//    [self reloadItemUI];
//}
//
//- (void)clearContent{
//    [self.items enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [obj removeFromSuperview];
//    }];
//    [(NSMutableArray *)self.items removeAllObjects];
//}
//
//- (void)enumItemsWith:(void (^)(NSUInteger index, UIView *itemV))enumBlock{
//    [self.items enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        enumBlock(idx,obj);
//    }];
//}
//
//#pragma mark 代理
//
//#pragma mark getter
//- (UIScrollView *)scroV{
//    if (!_scroV) {
//        _scroV = [UIScrollView new];
//    }
//    return _scroV;
//}
//- (UIView *)baseV{
//    if (!_baseV) {
//        _baseV = [UIView new];
//    }
//    return _baseV;
//}
//- (UIView *)contentV{
//    if (!_contentV) {
//        _contentV = [UIView new];
//    }
//    return _contentV;
//}
//- (NSMutableArray<NSLayoutConstraint *> *)edgeConstraints{
//    if (!_edgeConstraints) {
//        _edgeConstraints = [NSMutableArray array];
//    }
//    return _edgeConstraints;
//}
//- (NSArray<UIView *> *)items{
//    if (!_items) {
//        _items = [NSMutableArray array];
//    }
//    return _items;
//}
//
//@end
//
//@implementation WLMenuItemView
//
//- (instancetype)initWithNormalUIConfig:(UIConfig)normalUIConfig selectUIConfig:(UIConfig)selectUIconfig{
//    if (self = [super initWithFrame:CGRectZero]) {
//        self.normalUIConfig = normalUIConfig;
//        self.selectUIconfig = selectUIconfig;
//    }
//    return self;
//}
//
//@end
//
//
//
//@interface WLMenuView ()
//@property (assign, nonatomic,readwrite) NSInteger defaultIndex;
//@property (assign, nonatomic,readwrite) NSInteger selectedIndex;
//@property (strong, nonatomic) UIView *indicatorV;
//@property (strong, nonatomic) WLMenuItemView *selectItemV;
//@property (strong, nonatomic) IndicatorIndexChangeAct indicatorIndexChangeAct;
//@end
//@implementation WLMenuView
//#define BaseTag 321
//#pragma mark 生命周期
//- (instancetype)initWithItemArr:(NSArray <WLMenuItemView*>*)itemArr defaultSelectedIndex:(NSInteger)defaultSelectedIndex itemSpace:(CGFloat)itemSpace{
//    if (self = [super initWithContentEdge:UIEdgeInsetsZero itemSpace:itemSpace]) {
//        self.items = [itemArr mutableCopy];
//        self.defaultIndex = defaultSelectedIndex;
//        self.itemSpace = itemSpace;
//        self.shouldAutoCenter = true;
//        [self updateUI];
//    }
//    return self;
//}
//#pragma mark 通知/KVO/setter
//
//#pragma mark 界面布局
//- (void)updateUI{
//    [super reloadItemUI];
//    [UIView performWithoutAnimation:^{
//        [self.items enumerateObjectsUsingBlock:^(UIView * _Nonnull tItemV, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (![tItemV isKindOfClass:[WLMenuItemView class]]) {
//                return;
//            }
//            WLMenuItemView *itemV = (WLMenuItemView *)(WLMenuItemView *)tItemV;
//            if (idx == self.selectedIndex) {
//                self.selectItemV = itemV;
//                if (itemV.selectUIconfig) {
//                    itemV.selectUIconfig(itemV);
//                }
//            }else{
//                if (itemV.normalUIConfig) {
//                    itemV.normalUIConfig(itemV);
//                }
//            }
//            itemV.tag = BaseTag+idx;
//            [itemV addTarget:self action:@selector(tapItemV:) forControlEvents:UIControlEventTouchUpInside];
//        }];
//        if (self.indicatorIndexChangeAct) {
//            self.indicatorIndexChangeAct(self.selectedIndex, self.selectItemV, self, self.indicatorV);
//        }
//    }];
//}
//#pragma mark 数据请求
//
//#pragma mark 事件
//- (void)tapItemV:(WLMenuItemView *)itemV{
//    [self gotoIndex:itemV.tag-BaseTag animated:true shouldPerfomAct:true];
//}
//#pragma mark 逻辑
//- (void)updateMenuItems:(NSArray<WLMenuItemView*>*)itemArr defaultSelectIndex:(NSInteger)defaultSelectIndex{
//    self.items = itemArr;
//    self.defaultIndex = defaultSelectIndex;
//    [self updateUI];
//}
//
//- (void)configIndicator:(IndicatorUIConfigAct)configAct indexChangeAct:(IndicatorIndexChangeAct)indexChangeAct{
//    if (self.selectItemV == nil) {return;}
//    if (configAct) {
//        self.indicatorV = configAct(self.selectedIndex,self.selectItemV,self);
//    }
//    self.indicatorIndexChangeAct = indexChangeAct;
//}
//
//- (void)gotoIndex:(NSInteger)index animated:(BOOL)animated shouldPerfomAct:(BOOL)shouldPerfomAct{
//    if (index == self.selectedIndex) {
//        return;
//    }
//    if (index < 0 || index >= self.items.count) {
//        return;
//    }
//    WLMenuItemView *itemV = (WLMenuItemView*)self.items[index];
//    void (^act)(void) = ^{
//        BOOL shouldContinue = true;
//        if (self.indexWillChanged) {
//            shouldContinue = self.indexWillChanged(index,itemV);
//        }
//        if (shouldContinue) {
//            if (self.selectItemV && self.selectItemV.normalUIConfig) {
//                self.selectItemV.normalUIConfig(self.selectItemV);
//            }
//            self.selectedIndex = index;
//            self.selectItemV = itemV;
//            if (self.selectItemV.selectUIconfig) {
//                self.selectItemV.selectUIconfig(itemV);
//            }
//            if (self.indicatorIndexChangeAct) {
//                self.indicatorIndexChangeAct(self.selectedIndex, itemV, self, self.indicatorV);
//            }
//            if (self.indexDidChanged && shouldPerfomAct) {
//                self.indexDidChanged(index, itemV);
//            }
//        }
//    };
//    if (animated) {
//        [UIView animateWithDuration:0.2 animations:^{
//            act();
//        } completion:^(BOOL finished) {
//            [self centerItem:itemV animated:true];
//        }];
//    }else{
//        act();
//        [self centerItem:itemV animated:false];
//    }
//}
//
//- (void)gotIndexWithoutAct:(NSInteger)index{
//    if (index<0 || index>=self.items.count) {
//        return;
//    }
//    [self gotoIndex:index animated:false shouldPerfomAct:false];
//}
//
//- (void)centerItem:(WLMenuItemView *)itemV animated:(BOOL)animated{
//    if (!self.shouldAutoCenter) {
//        return;
//    }
//    void (^act)(void) = ^{
//        CGPoint position = [itemV convertPoint:CGPointMake(itemV.frame.size.width/2, 0) toView:self];
//        CGFloat space = self.frame.size.width/2-position.x;
//        CGFloat x = self.scroV.contentOffset.x-space;
//        x = MAX(0, x);
//        x = MIN(self.scroV.contentSize.width-self.scroV.frame.size.width, x);
//        [self.scroV setContentOffset:CGPointMake(x, 0) animated:false];
//    };
//    if (animated) {
//        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            act();
//        } completion:^(BOOL finished) {
//
//        }];
//    }else{
//        act();
//    }
//}
//#pragma mark 代理
//
//#pragma mark getter
//
//@end
