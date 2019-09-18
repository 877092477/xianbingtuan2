//
//  FNConnectionsChatImageCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsChatImageCell.h"

@interface FNConnectionsChatImageCell()

@property (nonatomic, strong) UIImageView *imgHeader;

@property (nonatomic, strong) UIImageView *imgBackground;

@property (nonatomic, strong) UIActivityIndicatorView *loading;

@property (nonatomic, strong) UIButton *btnResend;

@property (nonatomic, strong) UIImageView *imgPlay;

@end

@implementation FNConnectionsChatImageCell

#define MAX_WIDTH 150
#define MAX_HEIGHT 150

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void) configUI {
    _imgHeader = [[UIImageView alloc] init];
    _imgBackground = [[UIImageView alloc] init];
    _loading = [[UIActivityIndicatorView alloc] init];
    _btnResend = [[UIButton alloc] init];
    _imgPlay = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_imgBackground];
    [self.contentView addSubview:_loading];
    [self.contentView addSubview:_btnResend];
    [self.contentView addSubview:_imgPlay];
    
    @weakify(self)
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.width.height.mas_equalTo(40);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.top.equalTo(@10);
        make.right.lessThanOrEqualTo(@-60);
        make.bottom.lessThanOrEqualTo(@-10);
        make.width.mas_lessThanOrEqualTo(0);
        make.height.mas_lessThanOrEqualTo(0);
    }];
    
    [_loading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self_weak_.imgBackground.mas_right).offset(10);
        make.centerY.equalTo(self_weak_.imgBackground);
    }];
    
    [_btnResend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self_weak_.loading);
    }];
    
    [_imgPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self_weak_.imgBackground);
        make.width.height.mas_equalTo(36);
    }];
    _imgPlay.image = IMAGE(@"connections_chat_video_play");
    
    _imgHeader.cornerRadius = 20;
    
    self.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    _imgHeader.backgroundColor = UIColor.whiteColor;
    _imgBackground.contentMode = UIViewContentModeScaleAspectFit;
    
    _loading.color = UIColor.grayColor;
    
    [_btnResend setImage:IMAGE(@"connections_chat_resend") forState:UIControlStateNormal];
    [_btnResend addTarget:self action:@selector(onResend)];
}

- (void) setImage: (UIImage*)image size: (CGSize)size withHeader: (NSString*)headerUrl isLeft: (BOOL)isLeft withStatus: (int)status isVideo:(BOOL)isVideo{
    [_imgHeader sd_setImageWithURL:URL(headerUrl)];
    _imgBackground.image = image;
    _imgPlay.hidden = !isVideo || size.width == 0 || size.height == 0;
    [self updateWithSize:size withHeader:headerUrl isLeft:isLeft withStatus:status];
}

- (void) setImageURL: (NSString*)imgUrl size: (CGSize)size withHeader: (NSString*)headerUrl isLeft: (BOOL)isLeft withStatus: (int)status isVideo:(BOOL)isVideo{
    [_imgHeader sd_setImageWithURL:URL(headerUrl)];
    [_imgBackground sd_setImageWithURL:URL(imgUrl)];
    _imgPlay.hidden = !isVideo || size.width == 0 || size.height == 0;
    [self updateWithSize:size withHeader:headerUrl isLeft:isLeft withStatus:status];
}

- (void) updateWithSize: (CGSize)size withHeader: (NSString*)headerUrl isLeft: (BOOL)isLeft withStatus: (int)status{
    
    if (status == 1 || size.width == 0 || size.height == 0) {
        _loading.hidden = NO;
        [_loading startAnimating];
    } else {
        _loading.hidden = YES;
        [_loading stopAnimating];
    }
    _btnResend.hidden = status != 2;
    @weakify(self)
    if (isLeft) {
        [_imgHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.top.equalTo(@10);
            make.width.height.mas_equalTo(40);
            make.bottom.lessThanOrEqualTo(@-10);
        }];
        [_imgBackground mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@70);
            make.top.equalTo(@10);
            make.right.lessThanOrEqualTo(@-60);
            make.bottom.lessThanOrEqualTo(@-10);
        }];
        
        [_loading mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self_weak_.imgBackground.mas_right).offset(10);
            make.centerY.equalTo(self_weak_.imgBackground).priorityLow();
        }];
        
    } else {
        [_imgHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.top.equalTo(@10);
            make.width.height.mas_equalTo(40);
            make.bottom.lessThanOrEqualTo(@-10);
        }];
        [_imgBackground mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-70);
            make.top.equalTo(@10);
            make.left.greaterThanOrEqualTo(@60);
            make.bottom.lessThanOrEqualTo(@-10);
        }];
        [_loading mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self_weak_.imgBackground.mas_left).offset(-10);
            make.centerY.equalTo(self_weak_.imgBackground).priorityLow();
        }];
    }
    
    [_loading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.greaterThanOrEqualTo(self_weak_.imgHeader);
    }];
    
    if (size.width < MAX_WIDTH && size.height < MAX_HEIGHT) {
        [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(size.width);
            make.height.mas_equalTo(size.height);
        }];
    } else if (size.width / size.height < MAX_WIDTH / MAX_HEIGHT) {
        [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(size.width / size.height * MAX_HEIGHT);
            make.height.mas_equalTo(MAX_HEIGHT);
        }];
    } else {
        [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(MAX_WIDTH);
            make.height.mas_equalTo(MAX_WIDTH * size.height / size.width);
        }];
    }
}

- (void)onResend {
    if ([_delegate respondsToSelector:@selector(didchatCellResendSelect:)]) {
        [_delegate didchatCellResendSelect:self];
    }
}

@end
