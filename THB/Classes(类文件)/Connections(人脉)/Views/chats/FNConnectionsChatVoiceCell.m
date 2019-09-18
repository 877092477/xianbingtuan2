//
//  FNConnectionsChatVoiceCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsChatVoiceCell.h"
#import "UIImageView+Player.h"

@interface FNConnectionsChatVoiceCell()

@property (nonatomic, strong) UIImageView *imgHeader;

@property (nonatomic, strong) UIImageView *imgBackground;
@property (nonatomic, strong) UIImageView *imgVoice;
@property (nonatomic, strong) UILabel *lblContent;
@property (nonatomic, strong) UIView *vPoint;
@property (nonatomic, strong) UIActivityIndicatorView *loading;
@property (nonatomic, strong) UIButton *btnResend;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int imageIndex;

@property (nonatomic, assign) BOOL isLeft;

@end

@implementation FNConnectionsChatVoiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _isLeft = YES;
        [self configUI];
    }
    return self;
}

- (void) configUI {
    _imgHeader = [[UIImageView alloc] init];
    _imgBackground = [[UIImageView alloc] init];
    _imgVoice = [[UIImageView alloc] init];
    _lblContent = [[UILabel alloc] init];
    _vPoint = [[UIView alloc] init];
    _loading = [[UIActivityIndicatorView alloc] init];
    _btnResend = [[UIButton alloc] init];
    
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_imgBackground];
    [self.contentView addSubview:_imgVoice];
    [self.contentView addSubview:_lblContent];
    [self.contentView addSubview:_vPoint];
    [self.contentView addSubview:_loading];
    [self.contentView addSubview:_btnResend];
    
    @weakify(self)
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.width.height.mas_equalTo(40);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.top.equalTo(@10);
        make.right.lessThanOrEqualTo(@-60);
        make.bottom.lessThanOrEqualTo(@-10);
    }];
    [_imgVoice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self_weak_.imgBackground).offset(10);
        make.centerY.equalTo(self_weak_.imgBackground);
    }];
    [_lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self_weak_.imgBackground.mas_left).offset(20);
        make.right.lessThanOrEqualTo(self_weak_.imgBackground.mas_right).offset(-12);
        make.centerY.equalTo(self_weak_.imgBackground);
    }];
    [_vPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self_weak_.imgBackground.mas_right).offset(10);
        make.width.height.mas_equalTo(10);
        make.centerY.equalTo(self_weak_.imgBackground);
    }];
    [_loading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self_weak_.imgBackground.mas_right).offset(10);
        make.centerY.equalTo(self_weak_.imgHeader);
    }];
    [_btnResend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self_weak_.loading);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imgHeader.cornerRadius = 20;
    
    _lblContent.numberOfLines = 0;
    _lblContent.textColor = UIColor.blackColor;
    _lblContent.font = kFONT16;
    
//    _imgBackground.backgroundColor = UIColor.whiteColor;
//    _imgBackground.cornerRadius = 4;
    
//    _imgVoice.image = IMAGE(@"connections_chat_audio");
    
    _vPoint.backgroundColor = UIColor.redColor;
    _vPoint.cornerRadius = 5;
    
    _loading.color = UIColor.grayColor;
    
    [_btnResend setImage:IMAGE(@"connections_chat_resend") forState:UIControlStateNormal];
    [_btnResend addTarget:self action:@selector(onResend)];
}


- (void) setText: (NSString*)text withHeader: (NSString*)imgUrl isLeft: (BOOL)isLeft withStatus: (int)status {
    _lblContent.text = text;
    [_imgHeader sd_setImageWithURL:URL(imgUrl)];
    [_vPoint setHidden:YES];
    
    CGFloat percent = 0.4;
    CGFloat maxWidth = XYScreenWidth - 120;
    
    if (status == 1) {
        _loading.hidden = NO;
        [_loading startAnimating];
    } else {
        _loading.hidden = YES;
        [_loading stopAnimating];
    }
    _btnResend.hidden = status != 2;
    _isLeft = isLeft;
    @weakify(self)
    if (isLeft) {
        _imgVoice.image = IMAGE(@"connections_chat_audio_left_3");
        _imgBackground.image = IMAGE(@"connections_chat_message_left");
        [_imgHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.top.equalTo(@10);
            make.width.height.mas_equalTo(40);
            make.bottom.lessThanOrEqualTo(@-10);
        }];
        [_imgBackground mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@60);
            make.top.equalTo(@10);
            make.right.lessThanOrEqualTo(@-60);
            make.height.equalTo(self_weak_.imgHeader);
            make.width.mas_greaterThanOrEqualTo(percent * maxWidth);
        }];
        [_imgVoice mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self_weak_.imgBackground).offset(20);
            make.centerY.equalTo(self_weak_.imgBackground);
        }];
        [_lblContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self_weak_.imgVoice.mas_right).offset(8);
            make.right.lessThanOrEqualTo(self_weak_.imgBackground.mas_right).offset(-12);
            make.centerY.equalTo(self_weak_.imgBackground);
        }];
        [_vPoint mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self_weak_.imgBackground.mas_right).offset(10);
            make.width.height.mas_equalTo(10);
            make.centerY.equalTo(self_weak_.imgBackground);
        }];
        [_loading mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self_weak_.imgBackground.mas_right).offset(10);
            make.centerY.equalTo(self_weak_.imgHeader);
        }];
        
    } else {
        _imgVoice.image = IMAGE(@"connections_chat_audio_right_3");
        _imgBackground.image = IMAGE(@"connections_chat_message_right");
        [_imgHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.top.equalTo(@10);
            make.width.height.mas_equalTo(40);
            make.bottom.lessThanOrEqualTo(@-10);
        }];
        [_imgBackground mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(@60);
            make.top.equalTo(@10);
            make.right.equalTo(@-60);
            make.height.equalTo(self_weak_.imgHeader);
            make.width.mas_greaterThanOrEqualTo(percent * maxWidth);
        }];
        [_imgVoice mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self_weak_.imgBackground).offset(-20);
            make.centerY.equalTo(self_weak_.imgBackground);
        }];
        [_lblContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self_weak_.imgVoice.mas_left).offset(-8);
            make.left.lessThanOrEqualTo(self_weak_.imgBackground.mas_left).offset(12);
            make.centerY.equalTo(self_weak_.imgBackground);
        }];
        [_vPoint mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self_weak_.imgBackground.mas_left).offset(-10);
            make.width.height.mas_equalTo(10);
            make.centerY.equalTo(self_weak_.imgBackground);
        }];
        [_loading mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self_weak_.imgBackground.mas_left).offset(-10);
            make.centerY.equalTo(self_weak_.imgHeader);
        }];
    }
    
}

- (void)onResend {
    if ([_delegate respondsToSelector:@selector(didchatCellResendSelect:)]) {
        [_delegate didchatCellResendSelect:self];
    }
}

- (void)setIsPlaying: (BOOL) isPlaying {
    _isPlaying = isPlaying;
    if (_isPlaying) {
        if (_timer) {
            [_timer invalidate];
        }
        _imageIndex = 0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(playImages) userInfo:nil repeats:YES];
    } else {
        [_timer invalidate];
        _timer = nil;
        _imgVoice.image = _isLeft ? IMAGE(@"connections_chat_audio_left_3") : IMAGE(@"connections_chat_audio_right_3");
    }
}

- (void) playImages {
    _imageIndex %= 3;
    NSString *imageName = [NSString stringWithFormat:@"%@_%d", _isLeft ? @"connections_chat_audio_left" : @"connections_chat_audio_right", _imageIndex + 1];
    _imgVoice.image = IMAGE(imageName);
    _imageIndex++;
}

@end
