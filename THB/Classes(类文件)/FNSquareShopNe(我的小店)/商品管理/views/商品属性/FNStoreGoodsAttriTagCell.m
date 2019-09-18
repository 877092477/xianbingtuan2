//
//  FNStoreGoodsAttriTagCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/14.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsAttriTagCell.h"

@interface FNStoreGoodsAttriTagCell()

@property (nonatomic, strong) UIView *vContent;
@end

@implementation FNStoreGoodsAttriTagCell


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
        make.height.mas_equalTo(20);
        make.width.mas_lessThanOrEqualTo(XYScreenWidth - 20);
    }];
    
    [_lblTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@9);
        make.right.equalTo(@-9);
    }];
    [_lblTag setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_lblTag contentCompressionResistancePriorityForAxis:(UILayoutConstraintAxisHorizontal)];
    
    [_lblTag setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_lblTag contentHuggingPriorityForAxis:(UILayoutConstraintAxisHorizontal)];
    
    _vContent.cornerRadius = 4;
    _vContent.layer.borderColor = RGB(255, 102, 102).CGColor;
    _vContent.layer.borderWidth = 1;
    
    _lblTag.textColor = RGB(255, 102, 102);
    _lblTag.font = kFONT11;
    
}


@end
