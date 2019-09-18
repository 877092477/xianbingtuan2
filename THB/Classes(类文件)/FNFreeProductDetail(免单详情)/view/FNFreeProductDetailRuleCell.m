//
//  FNFreeProductDetailRuleCell.m
//  THB
//
//  Created by Weller on 2018/12/19.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNFreeProductDetailRuleCell.h"

@interface FNFreeProductDetailRuleRowView: UIView

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;

@end

@implementation FNFreeProductDetailRuleRowView

- (instancetype)initWithFrame: (CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    
    [self addSubview: _lblTitle];
    [self addSubview: _lblDesc];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.right.lessThanOrEqualTo(@0);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(_lblTitle.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    _lblTitle.textColor = RGB(78, 78, 78);
    _lblTitle.font = kFONT13;
    _lblTitle.numberOfLines = 0;
    
    _lblDesc.textColor = RGB(129, 128, 129);
    _lblDesc.font = kFONT12;
    _lblDesc.numberOfLines = 0;
}

@end

@interface FNFreeProductDetailRuleCell()

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIButton *btnInvite;
@property (nonatomic, strong) UILabel *lblInvite;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIView *vRule;

@property (nonatomic, strong) NSMutableArray<FNFreeProductDetailRuleRowView*> *rows;

@end

@implementation FNFreeProductDetailRuleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _rows = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vBackground = [[UIView alloc] init];
    _btnInvite = [[UIButton alloc] init];
    _lblInvite = [[UILabel alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _vRule = [[UIView alloc] init];

    [self.contentView addSubview: _vBackground];
    [_vBackground addSubview: _btnInvite];
    [_vBackground addSubview:_lblInvite];
    [_vBackground addSubview: _lblTitle];
    [_vBackground addSubview: _vRule];
    
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    [_btnInvite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@10);
        make.left.greaterThanOrEqualTo(@40);
        make.right.lessThanOrEqualTo(@-40);
        make.height.mas_equalTo(34);
    }];
    [_lblInvite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.left.equalTo(_btnInvite).offset(12);
        make.right.lessThanOrEqualTo(_btnInvite).offset(-12);
        make.centerY.equalTo(_btnInvite);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_btnInvite.mas_bottom).offset(20);
        make.left.greaterThanOrEqualTo(@40);
        make.right.lessThanOrEqualTo(@-40);
    }];
    [_vRule mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(_lblTitle.mas_bottom).offset(10);
        make.bottom.equalTo(@-10);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.clearColor;
    self.vBackground.backgroundColor = FNWhiteColor;
    self.vBackground.cornerRadius = 8;
    
    _btnInvite.backgroundColor = RED;
    _btnInvite.cornerRadius = 8;
    [_btnInvite addTarget:self action:@selector(onInviteClick)];
    
    _lblInvite.textColor = FNWhiteColor;
    _lblInvite.font = kFONT13;
    
    _lblTitle.textColor = RED;
    _lblInvite.font = kFONT13;
    
}

- (void) setTitles: (NSArray*)titles rules: (NSArray*)rules {
    if (titles.count != rules.count)
        return;
    
    for (FNFreeProductDetailRuleRowView *view in self.rows) {
        [view removeFromSuperview];
    }
    [self.rows removeAllObjects];
    
    for (NSInteger index = 0; index < titles.count; index ++) {
        FNFreeProductDetailRuleRowView *view = [[FNFreeProductDetailRuleRowView alloc] init];
        view.lblTitle.text = titles[index];
        view.lblDesc.text = rules[index];
        
        [_vRule addSubview:view];
        [_rows addObject:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0)
                make.top.equalTo(@0);
            else
                make.top.equalTo(_rows[index - 1].mas_bottom).offset(10);
            
            if (index == titles.count - 1)
                make.bottom.equalTo(@0);
            
            make.left.right.equalTo(@0);
        }];
    }
}

- (void) setInviteText: (NSString*)text Title: (NSString*)title {
    _lblInvite.text = text;
    _lblTitle.text = title;
}

- (void) onInviteClick {
    if ([_delegate respondsToSelector:@selector(didInviteButtonClick:)])
        [_delegate didInviteButtonClick:self];
}

@end
