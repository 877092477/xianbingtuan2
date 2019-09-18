//
//  FNMaskBannerBackgroundView.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMaskBannerBackgroundView.h"

@interface FNMaskBannerBackgroundView()

@property (nonatomic, strong) NSArray<NSString*>* images;

@property (nonatomic, strong) UIImageView *imgBackground;
@property (nonatomic, strong) UIImageView *imgForeground;

@end

@implementation FNMaskBannerBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgBackground = [[UIImageView alloc] init];
    _imgForeground = [[UIImageView alloc] init];
    
    [self addSubview:_imgBackground];
    [self addSubview:_imgForeground];
    
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_imgForeground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    
}

-(void)setBackgroundImage: (NSString*)imgUrl {
    [self.imgBackground sd_setImageWithURL:URL(imgUrl) placeholderImage:IMAGE(@"APP底图")];
}

-(void)setForegroundImage: (NSString*)imgUrl {
    [self.imgForeground sd_setImageWithURL:URL(imgUrl) placeholderImage:IMAGE(@"APP底图")];
}

-(void)setPercent: (CGFloat)percent {
//    let width = self.frame.width
//    let height = self.frame.height
//    let radius = sqrt(width * width + height * height) / 2
//
//    let finalRect = CGRect(x: (width / 2 - radius),
//                           y: (height / 2 - radius),
//                           width: radius * 2,
//                           height: radius * 2)
//    let circleMaskPathInitial = UIBezierPath(ovalIn: finalRect)
//    let maskLayer = CAShapeLayer()
//    maskLayer.path = circleMaskPathFinal.cgPath
//    self.layer.mask = maskLayer
    CGFloat pe = fabs(percent);
    CGFloat width = self.imgForeground.bounds.size.width * pe;
    CGFloat height = self.imgForeground.bounds.size.height * pe;
    CGFloat radius = sqrt(width * width + height * height);
    CGRect rect = CGRectMake(-radius,
                             self.imgForeground.bounds.size.height / 2 - radius,
                             radius * 2,
                             radius * 2);
    if (percent > 0) {
        rect = CGRectMake(self.imgForeground.bounds.size.width - radius,
                          self.imgForeground.bounds.size.height / 2 - radius,
                          radius * 2,
                          radius * 2);
    }
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = [UIBezierPath bezierPathWithOvalInRect:rect].CGPath;
    self.imgForeground.layer.mask = maskLayer;
    
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"=====%f", scrollView.contentOffset);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity {
    
}

@end
