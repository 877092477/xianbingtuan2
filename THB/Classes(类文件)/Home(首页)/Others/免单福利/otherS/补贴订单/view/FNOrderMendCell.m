//
//  FNOrderMendCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNOrderMendCell.h"

@interface FNOrderMendCell()

@property (nonatomic, strong) UIView *vBackground;

@property (nonatomic, copy) NSString *timeTitle;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNOrderMendCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vBackground = [[UIView alloc] init];
    _imgHeader = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _lblMore = [[UILabel alloc] init];
    _btnMore = [[UIButton alloc] init];
    _vLine = [[UIView alloc] init];
    
    [self.contentView addSubview: _vBackground];
    [_vBackground addSubview: _imgHeader];
    [_vBackground addSubview: _lblTitle];
    [_vBackground addSubview: _lblDesc];
    [_vBackground addSubview: _lblMore];
    [_vBackground addSubview: _btnMore];
    [_vBackground addSubview: _vLine];
    
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.bottom.equalTo(@-10);
        make.width.mas_equalTo(self.imgHeader.mas_height);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.top.equalTo(@10);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(10);
    }];
    [_lblMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.bottom.equalTo(@-10);
        make.right.lessThanOrEqualTo(_btnMore.mas_left).offset(-10);
    }];
    [_btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.bottom.equalTo(@-10);
        make.width.mas_equalTo(72);
        make.height.mas_equalTo(24);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.right.equalTo(@-10);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    _vBackground.backgroundColor = UIColor.whiteColor;
    
    _imgHeader.layer.masksToBounds = YES;
    _imgHeader.contentMode = UIViewContentModeScaleAspectFill;
    
    _lblTitle.textColor = RGB(60, 60, 60);
    _lblTitle.font = [UIFont systemFontOfSize:13];
    _lblTitle.numberOfLines = 2;
    
    _lblDesc.font = [UIFont systemFontOfSize:11];
    _lblDesc.textColor = RGB(200, 200, 200);
    
    _lblMore.font = [UIFont systemFontOfSize:12];
    _lblMore.textColor = RGB(140, 140, 140);
    
    [_btnMore setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _btnMore.titleLabel.font = kFONT12;
    _btnMore.backgroundColor = UIColor.redColor;
    _btnMore.cornerRadius = 1;
    [_btnMore addTarget:self action:@selector(onMoreClick)];
    _btnMore.enabled = NO;
    
//    [_imgHeader sd_setImageWithURL:URL(@"")];
//    _lblTitle.text = @"2018秋冬新款韩版假两件毛呢外套女中长款学生加厚流行毛呢大衣";
//    _lblDesc.text = @"下单时间: 2019-03-19 14:33:46";
//    [_btnMore setTitle:@"补充订单" forState:UIControlStateNormal];
    
    _vLine.backgroundColor = RGB(243, 243, 243);
    _vLine.hidden = YES;
}

- (void)setPadding: (CGFloat)padding {
    [_vBackground mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(padding, padding, 0, padding));
    }];
}

- (void)showLine: (BOOL)isShow {
    _vLine.hidden = !isShow;
}

- (void)onMoreClick {
    if ([_delegate respondsToSelector:@selector(didButtonClick:)]) {
        [_delegate didButtonClick:self];
    }
}

- (void)setCommission: (NSAttributedString*)commission {
    _endTime = nil;
    if (_timer)
        [_timer invalidate];
    _timer = nil;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"返还金额 "];
    [str appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", commission] attributes:@{NSForegroundColorAttributeName: UIColor.redColor}]];
    _lblMore.attributedText = commission;
}

- (void)setEndTime: (NSDate*)date withTitle: (NSString*)title {
    _endTime = date;
    _timeTitle = title;
    if (_timer)
        [_timer invalidate];
    
    [self updateTime];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)updateTime {
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    int second = [_endTime timeIntervalSinceDate:date];
    
    int h = second / 3600;
    int m = (second % 3600) / 60;
    int s = second % 60;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ", _timeTitle]];
    [str appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%02d", h] attributes:@{NSForegroundColorAttributeName: UIColor.whiteColor, NSBackgroundColorAttributeName: UIColor.blackColor, NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:12]}]];
    [str appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@":"] attributes:@{NSForegroundColorAttributeName: UIColor.blackColor}]];
    [str appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%02d", m] attributes:@{NSForegroundColorAttributeName: UIColor.whiteColor, NSBackgroundColorAttributeName: UIColor.blackColor, NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:12]}]];
    [str appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@":"] attributes:@{NSForegroundColorAttributeName: UIColor.blackColor}]];
    [str appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%02d", s] attributes:@{NSForegroundColorAttributeName: UIColor.whiteColor, NSBackgroundColorAttributeName: UIColor.blackColor, NSFontAttributeName: [UIFont fontWithName:@"Helvetica Neue" size:12]}]];
    _lblMore.attributedText = str;
}

@end
