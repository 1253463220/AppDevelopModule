//
//  ChinaMapView.m
//  Testing
//
//  Created by 王立 on 2021/9/21.
//  Copyright © 2021 apple. All rights reserved.
//

#import "ChinaMapView.h"
#import "ChinaMapWithName.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ChinaMapView()<UIScrollViewDelegate>
{
    
}


@end

@implementation ChinaMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configUI];
    }
    return self;
}

- (void)configUI{
    [self addSubview:self.scroV];
    [self.scroV addSubview:self.contentV];
    self.scroV.frame = self.bounds;
    self.scroV.contentSize = self.contentV.frame.size;
}

- (ChinaMapWithName *)contentV{
    if (!_contentV) {
        _contentV = [[ChinaMapWithName alloc] initWithFrame:self.bounds];
    }
    return _contentV;
}
- (UIScrollView *)scroV{
    if (!_scroV) {
        _scroV = [[UIScrollView alloc] init];
        _scroV.showsVerticalScrollIndicator = false;
        _scroV.showsHorizontalScrollIndicator = false;
        _scroV.delegate = self;
        _scroV.maximumZoomScale = 5;
        _scroV.minimumZoomScale = 1;
    }
    return _scroV;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.contentV;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    if (self.hideMakerAct) {
        self.hideMakerAct();
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.hideMakerAct) {
        self.hideMakerAct();
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
   self.contentV.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    if (scrollView.zoomScale == 1) {
//        [UIView animateWithDuration:0.2 animations:^{
            self.scroV.contentSize = self.scroV.frame.size;
            self.scroV.contentOffset = CGPointMake(0, 0);
            self.contentV.transform = CGAffineTransformIdentity;
            self.contentV.transform = self.contentV.baseTransform;
            self.contentV.frame = self.scroV.bounds;
//        }];
    }
}

@end
