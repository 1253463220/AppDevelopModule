//
//  DFTitleCellView.m
//  DongfengWuliu
//
//  Created by 王立 on 2020/11/30.
//  Copyright © 2020 DongfengWuliu. All rights reserved.
//

#import "DFTitleCellView.h"
#import "UIView+YXAction.h"
#define DFRGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1]
#define DFLineColor DFRGB16(0xf0f0f1)
#define DFNormalBlackColor DFRGB16(0x333333)
#define DFNormalGrayColor DFRGB16(0xa4a4a4)

@interface DFTitleCellView()

@property (strong, nonatomic, nullable) UIStackView *baseStackV;
@property (strong, nonatomic, nullable) UIStackView *leftStackV;
@property (strong, nonatomic, nullable) UIStackView *rightStackV;

@end

@implementation DFTitleCellView

#pragma mark 生命周期

- (instancetype)initWithConfig:(DFTitleCellConfigModel *)config{
    if (self = [super initWithFrame:CGRectMake(0, 0, 0, config.itemHeight)]){
        self.config = config;
        self.translatesAutoresizingMaskIntoConstraints = false;
        [self configUI];
    }
    return self;
}

+ (UIStackView *)createVerticalStackViewWith:(NSArray <DFTitleCellConfigModel*>*)configs enumerateBlock:(void (NS_NOESCAPE ^)(DFTitleCellView *cellView,DFTitleCellConfigModel *config, NSUInteger idx))enumerateBlock{
    UIStackView *stackV = [UIStackView new];
    stackV.axis = UILayoutConstraintAxisVertical;
    stackV.alignment = UIStackViewAlignmentFill;
    stackV.distribution = UIStackViewDistributionFill;
    stackV.translatesAutoresizingMaskIntoConstraints = false;
    [configs enumerateObjectsUsingBlock:^(DFTitleCellConfigModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DFTitleCellView *cell = [[DFTitleCellView alloc] initWithConfig:obj];
        enumerateBlock(cell,obj,idx);
        [stackV addArrangedSubview:cell];
    }];
    return stackV;
}
#pragma mark 通知

#pragma mark setter
- (void)setConfig:(DFTitleCellConfigModel *)config{
    if (_config == config) {
        return;
    }
    _config = config;
    for (UIView *subV in self.subviews) {
        [subV removeFromSuperview];
    }
    self.backV = nil;
    self.l_titleImgV = nil;
    self.l_starL = nil;
    self.l_titleL = nil;
    self.r_valueL = nil;
    self.r_imageV = nil;
    self.r_textTF = nil;
    self.r_arrowImgV = nil;
    self.r_swithcV = nil;
    self.lineV = nil;
    self.baseStackV = nil;
    self.leftStackV = nil;
    self.rightStackV = nil;
    [self configUI];
}

#pragma mark 界面布局
- (void)configUI{
    [self addSubview:self.backV];
    [self.backV addSubview:self.baseStackV];
    [self.backV addSubview:self.lineV];
    
    [self.baseStackV addArrangedSubview:self.leftStackV];
    [self.baseStackV addArrangedSubview:self.rightStackV];
    
    [self.leftStackV addArrangedSubview:self.l_titleImgV];
    [self.leftStackV addArrangedSubview:self.l_starL];
    [self.leftStackV addArrangedSubview:self.l_titleL];

    [[self.backV.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0] setActive:true];
    [[self.backV.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0] setActive:true];
    [[self.backV.topAnchor constraintEqualToAnchor:self.topAnchor constant:0] setActive:true];
    [[self.backV.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0] setActive:true];
    
    [[self.baseStackV.leftAnchor constraintEqualToAnchor:self.backV.leftAnchor constant:self.config.horizPadding] setActive:true];
    [[self.baseStackV.rightAnchor constraintEqualToAnchor:self.backV.rightAnchor constant:-self.config.horizPadding] setActive:true];
    [[self.baseStackV.topAnchor constraintEqualToAnchor:self.backV.topAnchor constant:0] setActive:true];
    [[self.baseStackV.bottomAnchor constraintEqualToAnchor:self.lineV.topAnchor constant:0] setActive:true];
    
    [[self.lineV.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.config.horizPadding] setActive:true];
    [[self.lineV.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-self.config.horizPadding] setActive:true];
    [[self.lineV.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0] setActive:true];
    [[self.lineV.heightAnchor constraintEqualToConstant:0.5] setActive:true];
    
    [[self.heightAnchor constraintGreaterThanOrEqualToConstant:self.config.itemHeight] setActive:true];
    
    [[self.rightStackV.topAnchor constraintEqualToAnchor:self.baseStackV.topAnchor constant:self.config.verticalPadding] setActive:true];
    [[self.leftStackV.heightAnchor constraintEqualToAnchor:self.rightStackV.heightAnchor] setActive:true];
    
    CGSize customViewSize = [self.config.customRightView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    switch (self.config.type) {
        case RightViewTypeOnlyTitle:
            self.rightStackV.hidden = true;
            break;
        case RightViewTypeLabel:
            [self.rightStackV addArrangedSubview:self.r_valueL];
            [[self.l_titleL.heightAnchor constraintEqualToAnchor:self.r_valueL.heightAnchor] setActive:true];
            break;
        case RightViewTypeImage:
            [self.rightStackV addArrangedSubview:self.r_imageV];
            break;
        case RightViewTypeTextField:
            [self.rightStackV addArrangedSubview:self.r_textTF];
            [[self.r_textTF.heightAnchor constraintEqualToConstant:self.config.itemHeight] setActive:true];
            break;
        case RightViewTypeOffOn:
            [self.rightStackV addArrangedSubview:self.r_swithcV];
            break;
        case RightViewTypeCustomView:
            [self.rightStackV addArrangedSubview:self.config.customRightView];
            [[self.config.customRightView.heightAnchor constraintEqualToConstant:customViewSize.height] setActive:true];
            [[self.config.customRightView.widthAnchor constraintEqualToConstant:customViewSize.width] setActive:true];
            break;
        default:
            break;
    }
    [self.rightStackV addArrangedSubview:self.r_arrowImgV];
    
    //标题图片
    self.l_titleImgV.hidden = !self.config.isShowTitleImg;
    if (self.config.isShowTitleImg) {
        [[self.l_titleImgV.heightAnchor constraintEqualToConstant:self.config.titleImgSize.height] setActive:true];
        [[self.l_titleImgV.widthAnchor constraintEqualToConstant:self.config.titleImgSize.width] setActive:true];
        if (self.l_titleL.superview != nil && self.l_titleL.superview == self.l_titleImgV.superview) {
            [[self.l_titleImgV.rightAnchor constraintEqualToAnchor:self.l_titleL.leftAnchor constant:self.config.titleImgRightMargin] setActive:true];
        }
    }
    //*标记
    self.l_starL.hidden = !self.config.isShowStar;
    //右边箭头
    self.r_arrowImgV.hidden = !self.config.isShowRightArrow;
    //下划线
    self.lineV.hidden = !self.config.isShowLine;
    //是否可点击
    if (self.config.isCanTap){
        __weak typeof(*&self) weakSelf = self;
        [self addTapAction:^(UITapGestureRecognizer *sender) {
            [weakSelf doTapAct];
        }];
    }
    //左stackView宽度
    if (self.config.leftStackWidth) {
        [[self.leftStackV.widthAnchor constraintEqualToConstant:self.config.leftStackWidth] setActive:true];
    }
    //左右satackView间距
    if (self.config.baseStackSpace){
        [[self.leftStackV.rightAnchor constraintEqualToAnchor:self.rightStackV.leftAnchor constant:-self.config.baseStackSpace] setActive:true];
    }
    //下部线条颜色
    if (self.config.lineColor) {
        self.lineV.backgroundColor = self.config.lineColor;
    }
    //左标题文字颜色
    if (self.config.titleLabelColor) {
        self.l_titleL.textColor = self.config.titleLabelColor;
    }
    //左标题文字大小
    if (self.config.titleLabelFont) {
        self.l_titleL.font = self.config.titleLabelFont;
    }
    //右label文字颜色
    if (self.config.valueLabelColor) {
        self.r_valueL.textColor = self.config.valueLabelColor;
    }
    //右label文字大小
    if (self.config.valueLabelFont) {
        self.r_valueL.font = self.config.valueLabelFont;
    }
    //整体背景色
    if (self.config.backColor) {
        self.backV.backgroundColor = self.config.backColor;
    }
    //左标题文字垂直布局
    self.l_titleL.textVerticalAlignment = self.config.leftTextVerticalAlignment;
    
}

#pragma mark 数据请求

#pragma mark 事件
- (void)doTapAct{
    if (self.config.tapBlock){
        self.config.tapBlock();
    }
}

#pragma mark 代理

#pragma mark getter

- (UIView *)backV{
    if (!_backV){
        _backV = [UIView new];
        _backV.translatesAutoresizingMaskIntoConstraints = false;
        _backV.backgroundColor = [UIColor whiteColor];
    }
    return  _backV;
}

- (UIView *)lineV{
    if (!_lineV){
        _lineV = [UIView new];
        _lineV.translatesAutoresizingMaskIntoConstraints = false;
        _lineV.backgroundColor = DFLineColor;
    }
    return  _lineV;;
}

- (UIImageView *)l_titleImgV{
    if (!_l_titleImgV){
        _l_titleImgV = [UIImageView new];
    }
    return _l_titleImgV;
}

- (WLVerticalAlignmentLabel *)l_starL{
    if (!_l_starL){
        _l_starL = [WLVerticalAlignmentLabel new];
        _l_starL.text = @"*";
        _l_starL.textColor = DFRGB16(0xF85D63);
        [_l_starL setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_l_starL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        _l_starL.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _l_starL;
}

- (WLVerticalAlignmentLabel *)l_titleL{
    if (!_l_titleL){
        _l_titleL = [WLVerticalAlignmentLabel new];
        _l_titleL.font = [UIFont systemFontOfSize:14];
        _l_titleL.textColor = DFNormalBlackColor;
        [_l_titleL setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_l_titleL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        _l_titleL.text = _config.title;
        _l_titleL.translatesAutoresizingMaskIntoConstraints = false;
    }
    return  _l_titleL;
}

- (UILabel *)r_valueL{
    if (!_r_valueL){
        _r_valueL = [UILabel new];
        _r_valueL.font = [UIFont systemFontOfSize:14];
        _r_valueL.textColor = DFNormalGrayColor;
        _r_valueL.translatesAutoresizingMaskIntoConstraints = false;
        _r_valueL.numberOfLines = 0;
        _r_valueL.textAlignment = NSTextAlignmentRight;
    }
    return  _r_valueL;
}

- (UIImageView *)r_imageV{
    if(!_r_imageV){
        _r_imageV = [UIImageView new];
        _r_imageV.translatesAutoresizingMaskIntoConstraints = false;
    }
    return  _r_imageV;
}

- (UIImageView *)r_arrowImgV{
    if (!_r_arrowImgV){
        _r_arrowImgV = [UIImageView new];
        _r_arrowImgV.image = [UIImage imageNamed:@"arrow_right"];
        _r_arrowImgV.translatesAutoresizingMaskIntoConstraints = false;
        [_r_arrowImgV setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_r_arrowImgV setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _r_arrowImgV;
}

- (UITextField *)r_textTF{
    if (!_r_textTF){
        _r_textTF = [UITextField new];
        _r_textTF.font = [UIFont systemFontOfSize:14];
        _r_textTF.textColor = DFNormalBlackColor;
        _r_textTF.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _r_textTF;
}

- (UISwitch *)r_swithcV{
    if (!_r_swithcV){
        _r_swithcV = [UISwitch new];
        _r_swithcV.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _r_swithcV;
}


- (UIStackView *)baseStackV{
    if (!_baseStackV){
        _baseStackV = [UIStackView new];
        _baseStackV.axis = UILayoutConstraintAxisHorizontal;
        _baseStackV.alignment = UIStackViewAlignmentCenter;
        _baseStackV.distribution = UIStackViewDistributionEqualSpacing;
        _baseStackV.translatesAutoresizingMaskIntoConstraints = false;
    }
    return  _baseStackV;
}

-(UIStackView *)leftStackV{
    if (!_leftStackV){
        _leftStackV = [UIStackView new];
        _leftStackV.axis = UILayoutConstraintAxisHorizontal;
        _leftStackV.alignment = UIStackViewAlignmentCenter;
        _leftStackV.distribution = UIStackViewDistributionFill;
        _leftStackV.translatesAutoresizingMaskIntoConstraints = false;
        _leftStackV.spacing = 3;
    }
    return _leftStackV;
}

-(UIStackView *)rightStackV{
    if (!_rightStackV){
        _rightStackV = [UIStackView new];
        _rightStackV.axis = UILayoutConstraintAxisHorizontal;
        _rightStackV.alignment = UIStackViewAlignmentCenter;
        _rightStackV.distribution = UIStackViewDistributionFill;
        _rightStackV.spacing = 3;
        _rightStackV.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _rightStackV;
}

@end
