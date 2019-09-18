//
//  FNLiveBroadcastLogCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveBroadcastLogCell.h"

@interface FNLiveBroadcastLogCellView()

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIImageView *imgType;
@property (nonatomic, strong) UILabel *lblLog;
@property (nonatomic, strong) UIImageView *imgRight;

@end

@implementation FNLiveBroadcastLogCellView

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
    _imgType = [[UIImageView alloc] init];
    _lblLog = [[UILabel alloc] init];
    _imgRight = [[UIImageView alloc] init];
    
    [self addSubview:_vBackground];
    [self addSubview:_imgType];
    [self addSubview:_lblLog];
    [self addSubview:_imgRight];
    
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(26);
//        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(4, 12, 4, 12));
        make.left.equalTo(@12);
        make.right.lessThanOrEqualTo(@-12);
        make.top.equalTo(@4);
        make.bottom.equalTo(@-4);
    }];
    [_imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.bottom.equalTo(@0);
        make.width.mas_equalTo(0);
    }];
    [_lblLog mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgType.mas_right).offset(12);
        make.right.equalTo(self.imgRight.mas_left).offset(-4);
        make.centerY.equalTo(self.vBackground);
    }];

    [_imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.vBackground).offset(-8);
        make.centerY.equalTo(self.vBackground);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(0);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    
    _vBackground.backgroundColor = RGBA(51, 51, 51, 1);
    _vBackground.cornerRadius = 13;
    
    _lblLog.text = @"asdadaq";
    _lblLog.textColor = UIColor.whiteColor;
    _lblLog.font = kFONT12;
    
    _imgType.contentMode = UIViewContentModeScaleAspectFit;
    _imgRight.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setLog: (NSString*)log withTypeImg: (NSString*)typeImage rightImg: (NSString*)rightImage alpha: (CGFloat)alpha {
    _lblLog.text = log;
    
    [_imgType mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.bottom.equalTo(@0);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(0);
    }];
    
    [_imgRight mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.vBackground).offset(-8);
        make.centerY.equalTo(self.vBackground);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(0);
    }];
    if ([typeImage kr_isNotEmpty]) {
        @weakify(self)
        [_imgType sd_setImageWithURL:URL(typeImage) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            @strongify(self)
            if (error == nil && image ) {
                [self.imgType mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@12);
                    make.top.bottom.equalTo(@0);
                    make.height.mas_equalTo(26);
                    make.width.mas_equalTo(26 / image.size.height * image.size.width);
                }];
            }
        }];
    }
    
    if ([rightImage kr_isNotEmpty]) {
        @weakify(self)
        [_imgRight sd_setImageWithURL:URL(rightImage) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            @strongify(self)
            if (error == nil && image ) {
                [self.imgRight mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.vBackground).offset(-8);
                    make.centerY.equalTo(self.vBackground);
                    make.height.mas_equalTo(18);
                    make.width.mas_equalTo(18 / image.size.height * image.size.width);
                }];
            }
        }];
    }
    
    self.alpha = alpha;
}

@end

@interface FNLiveBroadcastLogCell()

@property (nonatomic, strong) FNLiveBroadcastLogCellView *logView;

@end
@implementation FNLiveBroadcastLogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.clearColor;
    
    _logView = [[FNLiveBroadcastLogCellView alloc] init];
    [self.contentView addSubview:_logView];
    
    [_logView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}

- (void)setLog: (NSString*)log withTypeImg: (NSString*)typeImage rightImg: (NSString*)rightImage alpha: (CGFloat)alpha {
    [_logView setLog:log withTypeImg:typeImage rightImg:rightImage alpha:alpha];
}

@end
