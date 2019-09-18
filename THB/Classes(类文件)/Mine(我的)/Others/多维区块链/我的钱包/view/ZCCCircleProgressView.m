//
//  ZCCCircleProgressView.m
//  MOSOBOStudent
//
//  Created by mac on 2017/10/23.
//  Copyright © 2017年 zcc. All rights reserved.
//

#import "ZCCCircleProgressView.h"
 

@interface ZCCCircleProgressView()

@property (nonatomic, strong)UILabel *bottomLabel;

@property (nonatomic, strong)CAGradientLayer *gradientLayer;
//进度圆环
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
//半透明
@property (nonatomic, strong) CAShapeLayer *translucenceLayer;
//背景圆环
@property (nonatomic, strong) CAShapeLayer *bgLayer;

@end

@implementation ZCCCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)addCircleWithColor:(UIColor *)color{
    
    //圆路径
    //UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
    
    //UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2) radius:(self.width - 20)/2 startAngle:M_PI / 4 + M_PI / 2 endAngle:M_PI / 4 clockwise:YES];
    //UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2) radius:(self.width - 20)/2 startAngle: M_PI / 2 endAngle:M_PI / 2.01 clockwise:YES];
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2) radius:(self.width - 20)/2 startAngle: M_PI  endAngle:3*M_PI/1 clockwise:YES];
    
//    NSLog(@"center:%@", NSStringFromCGPoint(self.center));
    
//    NSLog(@"bounds:%@",NSStringFromCGPoint(self.bounds.origin));
    
    //先画一个背景环
    
    
    _bgLayer = [CAShapeLayer layer];
    _bgLayer.frame = self.bounds;
//    bgLayer.position = self.center;
    _bgLayer.fillColor = [UIColor clearColor].CGColor;//填充色 -  透明色
    _bgLayer.lineWidth = 15.f;
    _bgLayer.strokeColor = RGBA(122, 84, 249, 1.0).CGColor;//线条颜色
    _bgLayer.strokeStart = 0;
    _bgLayer.strokeEnd = 1;
    _bgLayer.lineCap = kCALineCapRound;
    _bgLayer.path = circlePath.CGPath;
    [self.layer addSublayer:_bgLayer];
   
    
    _translucenceLayer = [CAShapeLayer layer];
    _translucenceLayer.frame = self.bounds;
    _translucenceLayer.fillColor = [UIColor clearColor].CGColor;
    _translucenceLayer.lineWidth = 25.f;
    _translucenceLayer.lineCap = kCALineCapRound;
    //    _shapeLayer.strokeColor = color.CGColor;
    _translucenceLayer.strokeColor = RGBA(250, 187, 219, 0.5).CGColor;//线条颜色
    _translucenceLayer.strokeStart = 0;
    _translucenceLayer.strokeEnd = 0;
    
    _translucenceLayer.path = circlePath.CGPath;
    [self.layer addSublayer:_translucenceLayer];
    
    
    //一个红色进度
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = self.bounds;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.lineWidth = 15.f;
    _shapeLayer.lineCap = kCALineCapRound;
    //    _shapeLayer.strokeColor = color.CGColor;
    _shapeLayer.strokeColor = RGBA(251, 56, 160, 1.0).CGColor;//线条颜色
    _shapeLayer.strokeStart = 0;
    _shapeLayer.strokeEnd = 0;
    
    _shapeLayer.path = circlePath.CGPath;
    [self.layer addSublayer:_shapeLayer];
    
    
    
    //gradientLayer 上左边从下到上放一个渐变色 右边 从上到下放一个就按变色  最上面为中间值   中间颜色 和 起始颜色 还有结束颜色都从创建的时候传过来
    //这里黄色  255 255 0 到 红色 255  0  0  所以中间色是  255 255/2 0
    
    self.gradientLayer = [CAGradientLayer layer];
    
//    //左边的渐变图层
//    CAGradientLayer *leftGradientLayer = [CAGradientLayer layer];
//    leftGradientLayer.frame = CGRectMake(0, 0, self.width / 2, self.height);
//    [leftGradientLayer setColors:[NSArray arrayWithObjects:(id)ZCCRGBColor(255, 255, 0, 1).CGColor, (id)ZCCRGBColor(255, 255.0/2, 0, 1).CGColor, nil]];
//    [leftGradientLayer setLocations:@[@0,@0.9]];
//    [leftGradientLayer setStartPoint:CGPointMake(0, 1)];
//    [leftGradientLayer setEndPoint:CGPointMake(1, 0)];
//    [_gradientLayer addSublayer:leftGradientLayer];
//
//
//    CAGradientLayer *rightGradientLayer = [CAGradientLayer layer];
//    rightGradientLayer.frame = CGRectMake(self.width / 2, 0, self.width / 2, self.height);
//    [rightGradientLayer setColors:[NSArray arrayWithObjects:(id)ZCCRGBColor(255, 255.0 / 2, 0, 1.0).CGColor, (id)ZCCRGBColor(255, 0, 0, 1.0).CGColor, nil]];
//    [rightGradientLayer setLocations:@[@0.1, @1]];
//    [rightGradientLayer setStartPoint:CGPointMake(0.5, 0)];
//    [rightGradientLayer setEndPoint:CGPointMake(0.5, 1)];
//    [_gradientLayer addSublayer:rightGradientLayer];
//
//    [self.gradientLayer setMask:_shapeLayer];
//
//    self.gradientLayer.frame = self.bounds;
    //渐变图层映射到进度条路径上面
    
//    [self.layer addSublayer:self.gradientLayer];
    
    
//    CGRect rect = CGRectMake(50, 50, 100, 100);
//    CGSize radii = CGSizeMake(50, 50);
//    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft | UIRectCornerTopLeft;
//    //create path
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
//    //create shape layer
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    shapeLayer.lineWidth = 3;
//    shapeLayer.lineJoin = kCALineJoinRound;
//    shapeLayer.lineCap = kCALineCapRound;
//    shapeLayer.path = path.CGPath;
//    shapeLayer.lineDashPattern = @[@3, @6];//画虚线
//    //add it to our view
//    [self.layer addSublayer:shapeLayer];
//
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
//
//    [self addGestureRecognizer:tap];
}
- (void)addCircleWithColor:(UIColor *)color withPlan:(UIColor *)plancolor withEdge:(UIColor *)edgeColor{
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2) radius:(self.width - 20)/2 startAngle: 1.5*M_PI  endAngle:3.5*M_PI clockwise:YES];
    //Center:圆心 radius:半径 startAngle 开始位置  endAngle:结束位置  clockwise:是否顺否顺时针
    _bgLayer = [CAShapeLayer layer];
    _bgLayer.frame = self.bounds;
    _bgLayer.fillColor = [UIColor clearColor].CGColor;//填充色 -  透明色
    _bgLayer.lineWidth = 10.f;
    _bgLayer.strokeColor = color.CGColor;//设置背景色
    _bgLayer.strokeStart = 0;
    _bgLayer.strokeEnd = 1;
    _bgLayer.lineCap = kCALineCapRound;
    _bgLayer.path = circlePath.CGPath;
    [self.layer addSublayer:_bgLayer];
    
    _translucenceLayer = [CAShapeLayer layer];
    _translucenceLayer.frame = self.bounds;
    _translucenceLayer.fillColor = [UIColor clearColor].CGColor;
    _translucenceLayer.lineWidth = 25.f;
    _translucenceLayer.lineCap = kCALineCapRound;
    _translucenceLayer.strokeColor = edgeColor.CGColor;//设置边距色
    _translucenceLayer.strokeStart = 0;
    _translucenceLayer.strokeEnd = 0;
    _translucenceLayer.path = circlePath.CGPath;
    [self.layer addSublayer:_translucenceLayer];
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = self.bounds;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.lineWidth = 10.f;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.strokeColor = plancolor.CGColor;//进度颜色
    _shapeLayer.strokeStart = 0;
    _shapeLayer.strokeEnd = 0;
    
    _shapeLayer.path = circlePath.CGPath;
    [self.layer addSublayer:_shapeLayer];
    
}

- (void)addimaginaryLineWithColor:(UIColor *)color{
    //圆路径
    
    
    CGRect rect = CGRectMake(0, 0, self.width, self.height);
    CGSize radii = CGSizeMake(self.width, self.width);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft | UIRectCornerTopLeft;
        //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
        //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 1;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    shapeLayer.lineDashPattern = @[@1, @3];//画虚线
    
    [self.layer addSublayer:shapeLayer];
    //
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    //
    //    [self addGestureRecognizer:tap];
}

- (void)addLabelWithStr:(NSString *)str{
    
    self.bottomLabel.text = str;
}

- (UILabel *)bottomLabel{
    
    if(_bottomLabel == nil){
        //半径
        CGFloat width = self.width / 2;
        
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.width - width * 1.414) / 2, width / 1.414 + width, width * 1.414, 20)];
        
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        
        _bottomLabel.font = kFONT14;
        
        _bottomLabel.textColor = RGB(140, 140, 140);
        
        [self addSubview:_bottomLabel];
        
    }
    return _bottomLabel;
}

- (void)animateToProgress:(CGFloat)progress{
    
//    NSLog(@"增加到progress%lf", progress);
    
    if(_shapeLayer.strokeEnd != 0){
        [self animateToZero];
    }
    
    __weak typeof(self)weakSelf = self;
    
    NSLog(@"-----%lf",_shapeLayer.strokeEnd);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_shapeLayer.strokeEnd * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        [weakSelf deleteTimer];
        
        NSString *progressStr = [NSString stringWithFormat:@"%lf",progress];
        
        NSDictionary *userInfo = @{@"progressStr":progressStr};
        
        weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:weakSelf selector:@selector(animate:) userInfo:userInfo repeats:YES];
    });
    
}

- (void)animate:(NSTimer *)time{
    
    CGFloat progress = [[time.userInfo objectForKey:@"progressStr"]  floatValue];
    
    if(_shapeLayer.strokeEnd <= progress)
    {
        _shapeLayer.strokeEnd += 0.001;
        _translucenceLayer.strokeEnd += 0.001;
    }else{
        [self deleteTimer];
    }
}
//回滚到0  先判断 timer 有没有存在 存在 就把timer 删除
- (void)animateToZero{
    
//    NSLog(@"删除到0");
    
    [self deleteTimer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(animateReset) userInfo:nil repeats:YES];
}

- (void)animateReset{
    
    if(_shapeLayer.strokeEnd > 0){
        _shapeLayer.strokeEnd -= 0.001;
        _translucenceLayer.strokeEnd -= 0.001;
    }else{
        [self deleteTimer];
    }
    
}

- (void)deleteTimer{
    [self.timer invalidate];
    self.timer = nil;
}



- (void)tapImage:(UITapGestureRecognizer *)tapGestrue{
//    CGPoint tapPoint = [tapGestrue locationInView:tapGestrue.view];
//    
//    CGPoint redPoint = [_bgLayer convertPoint:tapPoint fromLayer:self.layer];
//    CGPoint yellowPoint = [_shapeLayer convertPoint:tapPoint fromLayer:self.layer];
    
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"point red" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
   
}
@end
