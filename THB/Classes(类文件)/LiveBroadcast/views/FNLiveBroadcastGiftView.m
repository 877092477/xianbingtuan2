//
//  FNLiveBroadcastGiftView.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveBroadcastGiftView.h"

@interface FNLiveBroadcastGiftView()



@end

@implementation FNLiveBroadcastGiftView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)randomGift {
    int i = (arc4random() % 27) + 1;
    CGSize size = self.bounds.size;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"live_broadcast_image_gift_%d",i+1]];
    imageView.frame = CGRectMake(size.width / 2, size.height, 30, 30);
    [self addSubview:imageView];
    
    UIBezierPath *randomPath = [self randomPath];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = randomPath.CGPath;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *opacityAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAni.beginTime = 2.0;
    opacityAni.fromValue = @1;
    opacityAni.toValue = @0;
    opacityAni.fillMode = kCAFillModeForwards;
    opacityAni.removedOnCompletion = NO;
    opacityAni.duration = 1.0;
    
    CABasicAnimation *scaleAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAni.fromValue = @1;
    scaleAni.toValue = @0.8;
    scaleAni.fillMode = kCAFillModeForwards;
    scaleAni.removedOnCompletion = NO;
    
    group.animations = @[animation,opacityAni,scaleAni];
    group.duration = 3.0;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    // 将动画添加到动画视图上
    [imageView.layer addAnimation:group forKey:@"ani"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imageView removeFromSuperview];
    });
    
}

- (UIBezierPath*)randomPath {
    CGSize size = self.bounds.size;
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 首先设置一个起始点
    CGPoint startPoint = CGPointMake(size.width / 2, size.height);
    [path moveToPoint:startPoint];
    
    CGPoint point1 = CGPointMake([self randomValueFrom:0 to:size.width], [self randomValueFrom:startPoint.y to:0]);
    CGPoint point2 = CGPointMake([self randomValueFrom:0 to:size.width], [self randomValueFrom:point1.y to:0]);
    CGPoint endPoint = CGPointMake([self randomValueFrom:0 to:size.width], 0);
    [path addCurveToPoint:endPoint controlPoint1:point1 controlPoint2:point2];
    
    return path;
}

- (CGFloat)randomValueFrom: (CGFloat)from to: (CGFloat)to {
    CGFloat percent = (CGFloat)(arc4random() % 100) / 100.0;
    return from + percent * (to - from);
}


@end
