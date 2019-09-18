//
//  FNConnectionsChatTextCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsChatTextCell.h"
@interface FNConnectionsChatTextCell()

@property (nonatomic, strong) UIImageView *imgHeader;

@property (nonatomic, strong) UIImageView *imgBackground;
@property (nonatomic, strong) UILabel *lblContent;
@property (nonatomic, strong) UIActivityIndicatorView *loading;
@property (nonatomic, strong) UIButton *btnResend;

 

@end

@implementation FNConnectionsChatTextCell

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
    _lblContent = [[UILabel alloc] init];
    _loading = [[UIActivityIndicatorView alloc] init];
    _btnResend = [[UIButton alloc] init];
    
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_imgBackground];
    [self.contentView addSubview:_lblContent];
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
    [_lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self_weak_.imgBackground.mas_left).offset(20);
        make.right.equalTo(self_weak_.imgBackground.mas_right).offset(-12);
        make.top.equalTo(self_weak_.imgBackground.mas_top).offset(12);
        make.bottom.equalTo(self_weak_.imgBackground.mas_bottom).offset(-12);
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
    
    _loading.color = UIColor.grayColor;
    
    [_btnResend setImage:IMAGE(@"connections_chat_resend") forState:UIControlStateNormal];
    [_btnResend addTarget:self action:@selector(onResend)];
}


- (void) setText: (NSString*)text withHeader: (NSString*)imgUrl isLeft: (BOOL)isLeft withStatus: (int)status {
    _lblContent.text = text;
    [_imgHeader sd_setImageWithURL:URL(imgUrl)];
    if (status == 1) {
        _loading.hidden = NO;
        [_loading startAnimating];
    } else {
        _loading.hidden = YES;
        [_loading stopAnimating];
    }
    
    _btnResend.hidden = status != 2;
    

    @weakify(self)
    _imgBackground.image = IMAGE(@"connections_chat_message_left");
    if (isLeft) {
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
            make.bottom.lessThanOrEqualTo(@-10);
        }];
        [_lblContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self_weak_.imgBackground.mas_left).offset(20);
            make.right.equalTo(self_weak_.imgBackground.mas_right).offset(-12);
            make.top.equalTo(self_weak_.imgBackground.mas_top).offset(12);
            make.bottom.equalTo(self_weak_.imgBackground.mas_bottom).offset(-12);
        }];
        [_loading mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self_weak_.imgBackground.mas_right).offset(10);
            make.centerY.equalTo(self_weak_.imgHeader);
        }];
        
    } else {
        _imgBackground.image = IMAGE(@"connections_chat_message_right");
        [_imgHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.top.equalTo(@10);
            make.width.height.mas_equalTo(40);
            make.bottom.lessThanOrEqualTo(@-10);
        }];
        [_imgBackground mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-60);
            make.top.equalTo(@10);
            make.left.greaterThanOrEqualTo(@60);
            make.bottom.lessThanOrEqualTo(@-10);
        }];
        [_lblContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self_weak_.imgBackground.mas_left).offset(12);
            make.right.equalTo(self_weak_.imgBackground.mas_right).offset(-20);
            make.top.equalTo(self_weak_.imgBackground.mas_top).offset(12);
            make.bottom.equalTo(self_weak_.imgBackground.mas_bottom).offset(-12);
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

@end
