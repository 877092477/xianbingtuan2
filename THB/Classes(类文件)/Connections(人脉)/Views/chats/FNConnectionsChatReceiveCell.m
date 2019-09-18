//
//  FNConnectionsChatReceiveCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsChatReceiveCell.h"

@interface FNConnectionsChatReceiveCell()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIImageView *imgRedPack;
@property (nonatomic, strong) UILabel *lblContent;

@end

@implementation FNConnectionsChatReceiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vContent = [[UIView alloc] init];
    _imgRedPack = [[UIImageView alloc] init];
    _lblContent = [[UILabel alloc] init];
    
    [self.contentView addSubview:_vContent];
    [self.vContent addSubview:_imgRedPack];
    [self.vContent addSubview:_lblContent];
    
    @weakify(self)
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.top.greaterThanOrEqualTo(@4);
        make.bottom.lessThanOrEqualTo(@-4);
    }];
    [_imgRedPack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@4);
        make.bottom.equalTo(@-4);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(15);
    }];
    [_lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self_weak_.imgRedPack.mas_right).offset(4);
        make.centerY.equalTo(@0);
        make.right.equalTo(@-10);
    }];
    self.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imgRedPack.image = IMAGE(@"connections_chat_redpack_small");
    
    _vContent.backgroundColor = RGB(200, 200, 200);
    _vContent.cornerRadius = 4;
    
//    _lblContent.text = @"小可爱领了你的红包";
    _lblContent.font = kFONT12;
    
}

- (void)setText: (NSString*)str {
    _lblContent.text = str;
}

@end
