//
//  FNStoreJoinTypeCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreJoinTypeCell.h"

@interface FNStoreJoinTypeCell()

@property (nonatomic, strong) UIView *vContent;
@end

@implementation FNStoreJoinTypeCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI {
    _vContent = [[UIView alloc] init];
    _lblTag = [[UILabel alloc] init];
    
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_lblTag];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.height.mas_equalTo(32);
        make.width.mas_lessThanOrEqualTo(XYScreenWidth - 32);
    }];
    
    [_lblTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
    }];
    [_lblTag setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_lblTag contentCompressionResistancePriorityForAxis:(UILayoutConstraintAxisHorizontal)];
    
    [_lblTag setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_lblTag contentHuggingPriorityForAxis:(UILayoutConstraintAxisHorizontal)];
    
    _vContent.cornerRadius = 16;
    _vContent.layer.borderColor = RGB(232, 232, 232).CGColor;
    _vContent.layer.borderWidth = 1;
    
    _lblTag.textColor = RGB(60, 60, 60);
    _lblTag.font = kFONT12;
    
}

- (void)setSelected: (BOOL)isSelected {
    if (isSelected) {
        _vContent.backgroundColor = RGB(255, 56, 46);
        _lblTag.textColor = UIColor.whiteColor;
    } else {
        _vContent.backgroundColor = UIColor.whiteColor;
        _lblTag.textColor = RGB(60, 60, 60);
    }
}

@end
