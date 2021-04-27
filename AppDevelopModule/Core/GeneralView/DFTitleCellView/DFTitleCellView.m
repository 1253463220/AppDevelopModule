//
//  DFTitleCellView.m
//  DongfengWuliu
//
//  Created by 王立 on 2020/11/30.
//  Copyright © 2020 DongfengWuliu. All rights reserved.
//

#import "DFTitleCellView.h"
#define DFRGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1]
#define DFLineColor DFRGB16(0xf0f0f1)
#define DFNormalBlackColor DFRGB16(0x333333)
#define DFNormalGrayColor DFRGB16(0xa4a4a4)

@interface DFTitleCellView()

@property (strong, nonatomic, nullable) UIStackView *baseStackV;
@property (strong, nonatomic, nullable) UIStackView *leftStackV;
@property (strong, nonatomic, nullable) UIStackView *rightStackV;
@property (strong, nonatomic, nullable) UIButton *actBtn;

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
    self.starL = nil;
    self.titleL = nil;
    self.valueL = nil;
    self.imageV = nil;
    self.textTF = nil;
    self.arrowImgV = nil;
    self.swithcV = nil;
    self.lineV = nil;
    self.baseStackV = nil;
    self.leftStackV = nil;
    self.rightStackV = nil;
    self.actBtn = nil;
    [self configUI];
}

#pragma mark 界面布局
- (void)configUI{
    [self addSubview:self.backV];
    [self.backV addSubview:self.baseStackV];
    [self.backV addSubview:self.lineV];
    
    [self.baseStackV addArrangedSubview:self.leftStackV];
    [self.baseStackV addArrangedSubview:self.rightStackV];
    
    [self.leftStackV addArrangedSubview:self.starL];
    [self.leftStackV addArrangedSubview:self.titleL];

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
    
    CGSize customViewSize = [self.config.customView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    switch (self.config.type) {
        case RightViewTypeOnlyTitle:
            self.rightStackV.hidden = true;
            break;
        case RightViewTypeLabel:
            [self.rightStackV addArrangedSubview:self.valueL];
            [[self.titleL.heightAnchor constraintEqualToAnchor:self.valueL.heightAnchor] setActive:true];
            break;
        case RightViewTypeImage:
            [self.rightStackV addArrangedSubview:self.imageV];
            break;
        case RightViewTypeTextField:
            [self.rightStackV addArrangedSubview:self.textTF];
            [[self.textTF.heightAnchor constraintEqualToConstant:self.config.itemHeight] setActive:true];
            break;
        case RightViewTypeOffOn:
            [self.rightStackV addArrangedSubview:self.swithcV];
            break;
        case RightViewTypeCustomView:
            [self.rightStackV addArrangedSubview:self.config.customView];
            [[self.config.customView.heightAnchor constraintEqualToConstant:customViewSize.height] setActive:true];
            [[self.config.customView.widthAnchor constraintEqualToConstant:customViewSize.width] setActive:true];
            break;
        default:
            break;
    }
    [self.rightStackV addArrangedSubview:self.arrowImgV];
    
    //*标记
    self.starL.hidden = !self.config.isShowStar;
    //右边箭头
    self.arrowImgV.hidden = !self.config.isShowArrow;
    //下划线
    self.lineV.hidden = !self.config.isShowLine;
    //是否可点击
    if (self.config.isCanTap){
        [self addSubview:self.actBtn];
        [[self.actBtn.topAnchor constraintEqualToAnchor:self.topAnchor] setActive:true];
        [[self.actBtn.leftAnchor constraintEqualToAnchor:self.leftAnchor] setActive:true];
        [[self.actBtn.bottomAnchor constraintEqualToAnchor:self.bottomAnchor] setActive:true];
        [[self.actBtn.rightAnchor constraintEqualToAnchor:self.rightAnchor] setActive:true];
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
        self.titleL.textColor = self.config.titleLabelColor;
    }
    //左标题文字大小
    if (self.config.titleLabelFont) {
        self.titleL.font = self.config.titleLabelFont;
    }
    //右label文字颜色
    if (self.config.valueLabelColor) {
        self.valueL.textColor = self.config.valueLabelColor;
    }
    //右label文字大小
    if (self.config.valueLabelFont) {
        self.valueL.font = self.config.valueLabelFont;
    }
    //整体背景色
    if (self.config.backColor) {
        self.backV.backgroundColor = self.config.backColor;
    }
    //左标题文字垂直布局
    self.titleL.textVerticalAlignment = self.config.leftTextVerticalAlignment;
    
}

#pragma mark 数据请求

#pragma mark 事件
- (void)tapActBtn{
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

- (WLVerticalAlignmentLabel *)starL{
    if (!_starL){
        _starL = [WLVerticalAlignmentLabel new];
        _starL.text = @"*";
        _starL.textColor = DFRGB16(0xF85D63);
        [_starL setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_starL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        _starL.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _starL;
}

- (WLVerticalAlignmentLabel *)titleL{
    if (!_titleL){
        _titleL = [WLVerticalAlignmentLabel new];
        _titleL.font = [UIFont systemFontOfSize:14];
        _titleL.textColor = DFNormalBlackColor;
        [_titleL setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_titleL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        _titleL.text = _config.title;
        _titleL.translatesAutoresizingMaskIntoConstraints = false;
    }
    return  _titleL;
}

- (UILabel *)valueL{
    if (!_valueL){
        _valueL = [UILabel new];
        _valueL.font = [UIFont systemFontOfSize:14];
        _valueL.textColor = DFNormalGrayColor;
        _valueL.translatesAutoresizingMaskIntoConstraints = false;
        _valueL.numberOfLines = 0;
        _valueL.textAlignment = NSTextAlignmentRight;
    }
    return  _valueL;
}

- (UIImageView *)imageV{
    if(!_imageV){
        _imageV = [UIImageView new];
        _imageV.translatesAutoresizingMaskIntoConstraints = false;
    }
    return  _imageV;
}

- (UIImageView *)arrowImgV{
    if (!_arrowImgV){
        _arrowImgV = [UIImageView new];
        _arrowImgV.image = [UIImage imageNamed:@"arrow_right"];
        _arrowImgV.translatesAutoresizingMaskIntoConstraints = false;
        [_arrowImgV setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_arrowImgV setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _arrowImgV;
}

- (UITextField *)textTF{
    if (!_textTF){
        _textTF = [UITextField new];
        _textTF.font = [UIFont systemFontOfSize:14];
        _textTF.textColor = DFNormalBlackColor;
        _textTF.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _textTF;
}

- (UISwitch *)swithcV{
    if (!_swithcV){
        _swithcV = [UISwitch new];
        _swithcV.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _swithcV;
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

- (UIButton *)actBtn{
    if (!_actBtn) {
        _actBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _actBtn.backgroundColor = [UIColor clearColor];
        _actBtn.translatesAutoresizingMaskIntoConstraints = false;
        [_actBtn addTarget:self action:@selector(tapActBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actBtn;
}

@end
