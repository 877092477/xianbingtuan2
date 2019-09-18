//
//  FNFreeProductDetailHeaderView.m
//  THB
//
//  Created by Weller on 2018/12/19.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNFreeProductDetailHeaderView.h"
#import "SDCycleScrollView/SDCycleScrollView.h"

@interface FNFreeProductDetailHeaderView()

//@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UIView        *vImage;

@property (nonatomic, strong) UIImageView   *vCount;
@property (nonatomic, strong) UILabel       *lblCountTitle;

@property (nonatomic, strong) UIView        *vPrice;
@property (nonatomic, strong) UILabel       *lblPriceTitle;

@property (nonatomic, strong) UIView        *vRight;
@property (nonatomic, strong) UILabel       *lblTimeTitle;
@property (nonatomic, strong) UIView        *vTime;
@property (nonatomic, strong) UILabel       *lblDay;
@property (nonatomic, strong) UILabel       *lblDayTitle;
@property (nonatomic, strong) UILabel       *lblHour;
@property (nonatomic, strong) UILabel       *lblHourTitle;
@property (nonatomic, strong) UILabel       *lblMin;
@property (nonatomic, strong) UILabel       *lblMinTitle;
@property (nonatomic, strong) UILabel       *lblSecond;

@property (nonatomic, strong) UIView        *vTitle;
    
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, strong) NSDate        *endTime;

@end

@implementation FNFreeProductDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vImage = [[UIView alloc] init];
    _vCount = [[UIImageView alloc] init];
    _lblCountTitle = [[UILabel alloc] init];
    _lblCount = [[UILabel alloc] init];
    _vPrice = [[UIView alloc] init];
    _lblPriceTitle = [[UILabel alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _lblOriginalPrice = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _vRight = [[UIView alloc] init];
    _lblTimeTitle = [[UILabel alloc] init];
    _vTime = [[UIView alloc] init];
    _lblDay = [[UILabel alloc] init];
    _lblDayTitle = [[UILabel alloc] init];
    _lblHour = [[UILabel alloc] init];
    _lblHourTitle = [[UILabel alloc] init];
    _lblMin = [[UILabel alloc] init];
    _lblMinTitle = [[UILabel alloc] init];
    _lblSecond = [[UILabel alloc] init];
    _vTitle = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    
    [self addSubview: _vImage];
    [self addSubview: _vCount];
    [_vCount addSubview: _lblCountTitle];
    [_vCount addSubview: _lblCount];
    [self addSubview: _vPrice];
    [_vPrice addSubview: _lblPriceTitle];
    [_vPrice addSubview: _lblPrice];
    [_vPrice addSubview: _lblOriginalPrice];
    [_vPrice addSubview: _lblDesc];
    [_vPrice addSubview: _vRight];
    [_vRight addSubview: _lblTimeTitle];
    [_vRight addSubview: _vTime];
    [_vTime addSubview: _lblDay];
    [_vTime addSubview: _lblDayTitle];
    [_vTime addSubview: _lblHour];
    [_vTime addSubview: _lblHourTitle];
    [_vTime addSubview: _lblMin];
    [_vTime addSubview: _lblMinTitle];
    [_vTime addSubview: _lblSecond];
    [self addSubview: _vTitle];
    [_vTitle addSubview: _lblTitle];

    [_vImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
    }];
    [_vCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@42);
        make.right.equalTo(@-20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(46);
    }];
    [_lblCountTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_vCount.mas_centerY).offset(-4);
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_vCount.mas_centerY);
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
    }];
    [_vPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(_vImage.mas_bottom);
        make.height.mas_equalTo(46);
    }];
    [_lblPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@8);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblPriceTitle.mas_right);
        make.bottom.equalTo(_lblPriceTitle).offset(2);
    }];
    [_lblOriginalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblPrice.mas_right).offset(4);
        make.bottom.equalTo(_lblPriceTitle);
        make.right.lessThanOrEqualTo(_vRight.mas_left);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(_lblPriceTitle.mas_bottom).offset(4);
        make.right.lessThanOrEqualTo(_vRight.mas_left);
    }];
    [_vRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.top.greaterThanOrEqualTo(@10);
        make.bottom.lessThanOrEqualTo(@-10);
        make.centerY.equalTo(@0);
    }];
    [_lblTimeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.centerX.equalTo(@0);
    }];
    [_vTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(_lblTimeTitle.mas_bottom).offset(4);
        make.bottom.equalTo(@0);
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.centerX.equalTo(@0);
    }];
    [_lblDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.bottom.equalTo(@0);
    }];
    [_lblDayTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblDay.mas_right);
        make.top.bottom.equalTo(@0);
    }];
    [_lblHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblDayTitle.mas_right);
        make.top.bottom.equalTo(@0);
    }];
    [_lblHourTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblHour.mas_right);
        make.top.bottom.equalTo(@0);
    }];
    [_lblMin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblHourTitle.mas_right);
        make.top.bottom.equalTo(@0);
    }];
    [_lblMinTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblMin.mas_right);
        make.top.bottom.equalTo(@0);
    }];
    [_lblSecond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblMinTitle.mas_right);
        make.top.bottom.equalTo(@0);
        make.right.equalTo(@0);
    }];
    [_vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(_vPrice.mas_bottom);
        make.height.mas_equalTo(46);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
//        make.top.equalTo(@10);
//        make.bottom.equalTo(@-10);
        make.right.lessThanOrEqualTo(@-10);
        make.centerY.equalTo(@0);
    }];
    
//    _vCount.backgroundColor = RGBA(244, 62, 121, 0.2);
    _vCount.image = IMAGE(@"free_image_circle");
    
    _lblCountTitle.textColor = RED;
    _lblCountTitle.font = [UIFont systemFontOfSize:9];
    _lblCountTitle.text = @"剩余";
    
    _lblCount.textColor = RED;
    _lblCount.font = [UIFont systemFontOfSize:12];
    
    _vPrice.backgroundColor = RED;
    
    _lblPriceTitle.textColor = FNWhiteColor;
    _lblPriceTitle.font = [UIFont systemFontOfSize:12];
    _lblPriceTitle.text = @"到手价：";
    
    _lblPrice.textColor = FNWhiteColor;
    _lblPrice.font = [UIFont systemFontOfSize:16];
    
    _lblOriginalPrice.textColor = FNWhiteColor;
    _lblOriginalPrice.font = [UIFont systemFontOfSize:9];
    
    _lblDesc.textColor = FNWhiteColor;
    _lblDesc.font = [UIFont systemFontOfSize:9];
    
    _lblTimeTitle.textColor = FNWhiteColor;
    _lblTimeTitle.font = [UIFont systemFontOfSize:9];
    _lblTimeTitle.text = @"距离活动结束仅剩";
    
    _lblDay.textColor = FNWhiteColor;
    _lblDay.font = [UIFont systemFontOfSize:8];
    _lblDay.text = @"03";
    _lblDay.backgroundColor = RGB(226, 41, 101);
    _lblDay.cornerRadius = 4;
    
    _lblDayTitle.textColor = FNWhiteColor;
    _lblDayTitle.font = [UIFont systemFontOfSize:8];
    _lblDayTitle.text = @"天";
    
    
    _lblHour.textColor = FNWhiteColor;
    _lblHour.font = [UIFont systemFontOfSize:8];
    _lblHour.text = @"12";
    _lblHour.backgroundColor = RGB(226, 41, 101);
    _lblHour.cornerRadius = 4;
    
    _lblHourTitle.textColor = FNWhiteColor;
    _lblHourTitle.font = [UIFont systemFontOfSize:8];
    _lblHourTitle.text = @"：";
    
    _lblMin.textColor = FNWhiteColor;
    _lblMin.font = [UIFont systemFontOfSize:8];
    _lblMin.text = @"09";
    _lblMin.backgroundColor = RGB(226, 41, 101);
    _lblMin.cornerRadius = 4;
    
    _lblMinTitle.textColor = FNWhiteColor;
    _lblMinTitle.font = [UIFont systemFontOfSize:8];
    _lblMinTitle.text = @"：";
    
    _lblSecond.textColor = FNWhiteColor;
    _lblSecond.font = [UIFont systemFontOfSize:8];
    _lblSecond.text = @"03";
    _lblSecond.backgroundColor = RGB(226, 41, 101);
    _lblSecond.cornerRadius = 4;
    
    _vTitle.backgroundColor = FNWhiteColor;
    
    _lblTitle.font = [UIFont systemFontOfSize:13];
    _lblTitle.textColor = RGB(129, 128, 129);
    _lblTitle.numberOfLines = 2;
}

- (void) setImages: (NSArray*) images {
    if (_cycleScrollView)
        [_cycleScrollView removeFromSuperview];
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:_vImage.frame imageURLStringsGroup:images];
    _cycleScrollView.autoScrollTimeInterval = 15;
    _cycleScrollView.delegate= self;
    [_vImage addSubview:_cycleScrollView];
    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (void) setTime: (NSDate*) date {
    
    _endTime = date;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    
    //加入runloop循环池
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    
    //开启定时器
    [_timer fire];
    
    
}
    
- (void)dealloc
    {
        
    }
    
- (void)invalidate {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
    

-(void)timerStart:(NSTimer *)timer{
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    int second = [_endTime timeIntervalSinceDate:now];
    
    if (second > 0) {
        int day = second / (3600 * 24);
        second = second % (3600 * 24);
        int hour = second / 3600;
        second = second % 3600;
        int min = second / 60;
        second = second % 60;
        
        _lblDay.text = [NSString stringWithFormat:@"%d", day];
        _lblHour.text = [NSString stringWithFormat:@"%d", hour];
        _lblMin.text = [NSString stringWithFormat:@"%d", min];
        _lblSecond.text = [NSString stringWithFormat:@"%d", second];
    } else {
        _lblDay.text = @"0";
        _lblHour.text = @"0";
        _lblMin.text = @"0";
        _lblSecond.text = @"0";
    }
}

@end
