//
//  FNVideoCardBuyCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoCardBuyCell.h"

@interface FNVideoCardBuyCell()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;

@property (nonatomic, strong) UIView *vCount;
@property (nonatomic, strong) UIButton *btnSub;
@property (nonatomic, strong) UILabel *lblCount;
@property (nonatomic, strong) UIButton *btnAdd;

@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, assign) NSInteger count;

@end

@implementation FNVideoCardBuyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _vCount = [[UIView alloc] init];
    _btnSub = [[UIButton alloc] init];
    _lblCount = [[UILabel alloc] init];
    _btnAdd = [[UIButton alloc] init];
    
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblDesc];
    [self.contentView addSubview:_vCount];
    [_vCount addSubview:_btnSub];
    [_vCount addSubview:_lblCount];
    [_vCount addSubview:_btnAdd];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.centerY.equalTo(@0);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(self.lblTitle.mas_right);
        make.right.equalTo(@-30);
        make.centerY.equalTo(@0);
    }];
    [_vCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(self.lblTitle.mas_right);
        make.right.equalTo(@-30);
        make.centerY.equalTo(@0);
    }];
    [_btnSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.width.height.mas_equalTo(20);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnSub.mas_right).offset(10);
        make.right.equalTo(self.btnAdd.mas_left).offset(-10);
        make.centerY.equalTo(@0);
        make.width.mas_greaterThanOrEqualTo(40);
    }];
    [_btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@0);
        make.width.height.mas_equalTo(20);
    }];
    
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = RGB(240, 240, 240);
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = [UIFont systemFontOfSize:18];
    
    _lblDesc.textColor = RGB(102, 102, 102);
    _lblDesc.font = [UIFont systemFontOfSize:18];
    
    _lblCount.textColor = RGB(51, 51, 51);
    _lblCount.font = [UIFont systemFontOfSize:24];
    _lblCount.textAlignment = NSTextAlignmentCenter;
    
    [_btnSub setImage:IMAGE(@"video_card_buy_button_sub_normal") forState:UIControlStateNormal];
    [_btnSub setImage:IMAGE(@"video_card_buy_button_sub_disable") forState:UIControlStateDisabled];
    [_btnSub addTarget:self action:@selector(onSubClick)];
    
    [_btnAdd setImage:IMAGE(@"video_card_buy_button_add_normal") forState:UIControlStateNormal];
    [_btnAdd setImage:IMAGE(@"video_card_buy_button_add_disable") forState:UIControlStateDisabled];
    [_btnAdd addTarget:self action:@selector(onAddClick)];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)onSubClick {
    _count --;
    [self updateCount];
    
    if ([_delegate respondsToSelector:@selector(cell:didCountChange:)]) {
        [_delegate cell:self didCountChange:_count];
    }
}

- (void)onAddClick {
    _count ++;
    [self updateCount];
    if ([_delegate respondsToSelector:@selector(cell:didCountChange:)]) {
        [_delegate cell:self didCountChange:_count];
    }
}

- (void)updateCount {
    _lblCount.text = [NSString stringWithFormat:@"%ld", _count];
    _btnAdd.enabled = _count < _maxCount;
    _btnSub.enabled = _count > 1;
}

- (void)setTitle: (NSString*)title count: (NSInteger)count withMaxCount: (NSInteger)maxCount {
    _count = count;
    [self updateCount];
    _lblTitle.text = title;
    _maxCount = maxCount;
    _lblDesc.hidden = YES;
    _vCount.hidden = NO;
}
- (void)setTitle: (NSString*)title withAttributeDesc: (NSAttributedString*)desc {
    _lblTitle.text = title;
    _lblDesc.attributedText = desc;
    _lblDesc.hidden = NO;
    
    _vCount.hidden = YES;
    _count = 1;
    _lblCount.text = @"1";
}

@end
