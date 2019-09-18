//
//  FNNetCouponeReceiveCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/11.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNetCouponeReceiveCell.h"

@interface FNNetCouponeReceiveCell()

@property (nonatomic, strong) NSDate *startTime;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation FNNetCouponeReceiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

- (void)configUI {
    _vContent = [[UIView alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _prgCount = [[UIProgressView alloc] init];
    _lblCount = [[UILabel alloc] init];
    _imgRight = [[UIImageView alloc] init];
    _lblReceive = [[UILabel alloc] init];
    _vRight = [[UIView alloc] init];
    _lblRightTitle = [[UILabel alloc] init];
    _vTime = [[UIView alloc] init];
    _vHour = [[UIView alloc] init];
    _lblHour = [[UILabel alloc] init];
    _vMin = [[UIView alloc] init];
    _lblMin = [[UILabel alloc] init];
    _vSecond = [[UIView alloc] init];
    _lblSecond = [[UILabel alloc] init];
    _btnRemind = [[UIButton alloc] init];
    _lblSymbol1 = [[UILabel alloc] init];
    _lblSymbol2 = [[UILabel alloc] init];
    
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_lblPrice];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_lblDesc];
    [_vContent addSubview:_prgCount];
    [_vContent addSubview:_lblCount];
    [_vContent addSubview:_imgRight];
    [_vContent addSubview:_lblReceive];
    [_vContent addSubview:_vRight];
    [_vRight addSubview:_lblRightTitle];
    [_vRight addSubview:_vTime];
    [_vTime addSubview:_vHour];
    [_vHour addSubview:_lblHour];
    [_vTime addSubview:_vMin];
    [_vMin addSubview:_lblMin];
    [_vTime addSubview:_vSecond];
    [_vSecond addSubview:_lblSecond];
    [_vTime addSubview:_lblSymbol1];
    [_vTime addSubview:_lblSymbol2];
    [_vRight addSubview:_btnRemind];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.centerY.equalTo(@0);
        make.width.mas_equalTo(70);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@18);
        make.left.equalTo(self.lblPrice.mas_right).offset(10);
        make.right.lessThanOrEqualTo(self.imgRight.mas_left).offset(-20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitle.mas_bottom).offset(8);
        make.left.equalTo(self.lblPrice.mas_right).offset(10);
        make.right.lessThanOrEqualTo(self.imgRight.mas_left).offset(-20);
    }];
    [_prgCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-10);
        make.left.equalTo(self.lblPrice.mas_right).offset(10);
        make.right.equalTo(self.imgRight.mas_left).offset(-20);
        make.height.mas_equalTo(10);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.prgCount);
        make.right.equalTo(self.prgCount).offset(-2);
    }];
    [_imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@0);
        make.width.mas_equalTo(113);
    }];
    [_lblReceive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.imgRight);
        make.top.left.greaterThanOrEqualTo(self.imgRight).offset(10);
        make.bottom.right.lessThanOrEqualTo(self.imgRight).offset(-10);
    }];
    [_vRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.imgRight);
    }];
    [_lblRightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@10);
        make.right.lessThanOrEqualTo(@-10);
        make.top.equalTo(@12);
        make.centerX.equalTo(@0);
    }];
    [_vTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@10);
        make.right.lessThanOrEqualTo(@-10);
        make.top.equalTo(self.lblRightTitle.mas_bottom).offset(6);
        make.centerX.equalTo(@0);
    }];
    [_vHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    [_lblHour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    [_lblSymbol1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vHour.mas_right).offset(2);
        make.right.equalTo(self.vMin.mas_left).offset(-2);
        make.centerY.equalTo(@0);
    }];
    [_lblSymbol2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vMin.mas_right).offset(2);
        make.right.equalTo(self.vSecond.mas_left).offset(-2);
        make.centerY.equalTo(@0);
    }];
    [_vMin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    [_lblMin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    [_vSecond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    [_lblSecond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    [_btnRemind mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.greaterThanOrEqualTo(@10);
//        make.right.lessThanOrEqualTo(@-10);
        make.bottom.equalTo(@-10);
        make.height.mas_equalTo(20);
        make.centerX.equalTo(@0);
        make.width.mas_equalTo(0);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _vContent.layer.backgroundColor = UIColor.whiteColor.CGColor;
    _vContent.layer.cornerRadius = 20;
    
    _lblPrice.font = [UIFont boldSystemFontOfSize:43];
    _lblPrice.textColor = RGB(167, 130, 24);
//    _lblPrice.textAlignment = NSTextAlignmentCenter;
    _lblPrice.adjustsFontSizeToFitWidth = YES;
    
    _lblTitle.font = [UIFont boldSystemFontOfSize:18];
    _lblTitle.textColor = RGB(35, 35, 42);
    
    _lblDesc.font = kFONT12;
    _lblDesc.textColor = RGB(219, 182, 106);
    
    _prgCount.progressTintColor = [UIColor colorWithHexString:@"#F0B938"];
    _prgCount.layer.cornerRadius = 5;
    _prgCount.layer.masksToBounds = YES;
    
    _lblCount.font = [UIFont systemFontOfSize:9];
    _lblCount.textColor = RGB(241, 144, 40);
    
    _lblReceive.text = @"马上抢";
    _lblReceive.textColor = RGB(167, 130, 24);
    _lblReceive.font = [UIFont boldSystemFontOfSize:18];
    
    _lblRightTitle.font = [UIFont boldSystemFontOfSize:12];
    _lblRightTitle.textColor = RGB(40, 41, 49);
    
    _vHour.layer.backgroundColor = RGB(248, 216, 73).CGColor;
    _vHour.layer.cornerRadius = 2;
    _vMin.layer.backgroundColor = RGB(248, 216, 73).CGColor;
    _vMin.layer.cornerRadius = 2;
    _vSecond.layer.backgroundColor = RGB(248, 216, 73).CGColor;
    _vSecond.layer.cornerRadius = 2;
    
    _lblHour.font = [UIFont boldSystemFontOfSize:12];
    _lblHour.textColor = RGB(40, 41, 49);
    _lblMin.font = [UIFont boldSystemFontOfSize:12];
    _lblMin.textColor = RGB(40, 41, 49);
    _lblSecond.font = [UIFont boldSystemFontOfSize:12];
    _lblSecond.textColor = RGB(40, 41, 49);
    
    _lblSymbol1.font = [UIFont boldSystemFontOfSize:12];
    _lblSymbol1.textColor = RGB(40, 41, 49);
    _lblSymbol1.text = @":";
    
    _lblSymbol2.font = [UIFont boldSystemFontOfSize:12];
    _lblSymbol2.textColor = RGB(40, 41, 49);
    _lblSymbol2.text = @":";
    
    [_btnRemind addTarget:self action:@selector(onRemindClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTime: (NSDate *)startTime  {
    _startTime = startTime;
    
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    int second = [startTime timeIntervalSinceDate:now];
    
    _vRight.hidden = second <= 0;
    _lblReceive.hidden = second > 0;
    if (second > 0) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    
}

- (void)updateTime {
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    int second = [_startTime timeIntervalSinceDate:now];
    if (second < 0) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    
    int h = second / 3600;
    int m = (second % 3600) / 60;
    int s = second % 60;
    
    _lblHour.text = [NSString stringWithFormat: @"%2d", h];
    _lblMin.text = [NSString stringWithFormat: @"%2d", m];
    _lblSecond.text = [NSString stringWithFormat: @"%2d", s];
}

- (void)onRemindClick {
    if ([_delegate respondsToSelector:@selector(didRemindClick:)]) {
        [_delegate didRemindClick:self];
    }
}

@end
