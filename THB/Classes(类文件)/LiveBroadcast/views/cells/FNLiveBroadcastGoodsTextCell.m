//
//  FNLiveBroadcastGoodsTextCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveBroadcastGoodsTextCell.h"

@interface FNLiveBroadcastGoodsTextCell()

@property (nonatomic, strong) UIView *vContent;

@end

@implementation FNLiveBroadcastGoodsTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _imgHeader = [[UIImageView alloc] init];
    _vContent = [[UIView alloc] init];
    _lblContent = [[UILabel alloc] init];
    
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_lblContent];
    
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@20);
        make.width.height.mas_equalTo(36);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.top.equalTo(@20);
        make.right.lessThanOrEqualTo(@-70);
        make.bottom.equalTo(@-20);
    }];
    [_lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    _imgHeader.cornerRadius = 13;
    _imgHeader.contentMode = UIViewContentModeScaleToFill;
    
    _vContent.cornerRadius = 5;
    _vContent.borderColor = RGB(249, 240, 249);
    _vContent.borderWidth = 1;
    
    _lblContent.textColor = RGB(51, 51, 51);
    _lblContent.font = kFONT12;
    _lblContent.numberOfLines = 0;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress)];
    [self.vContent addGestureRecognizer:press];
}

- (void)onLongPress {
    if ([_delegate respondsToSelector:@selector(didLongPress:)]) {
        [_delegate didLongPress:self];
    }
}

@end
