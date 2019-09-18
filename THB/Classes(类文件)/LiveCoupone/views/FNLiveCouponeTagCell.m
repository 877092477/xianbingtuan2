//
//  FNLiveCouponeTagCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/24.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveCouponeTagCell.h"

@interface FNLiveCouponeTagCell()

@property (nonatomic, strong) UIView *vContent;

@end

@implementation FNLiveCouponeTagCell

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
        make.height.mas_equalTo(30);
        make.width.mas_lessThanOrEqualTo(XYScreenWidth - 20);
    }];
    
    [_lblTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@18);
        make.right.equalTo(@-18);
    }];
    [_lblTag setContentCompressionResistancePriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_lblTag contentCompressionResistancePriorityForAxis:(UILayoutConstraintAxisHorizontal)];
    
    [_lblTag setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    [_lblTag contentHuggingPriorityForAxis:(UILayoutConstraintAxisHorizontal)];
    
    
    _vContent.backgroundColor = RGB(248, 248, 248);
    _vContent.cornerRadius = 15;
    
    _lblTag.textColor = RGB(102, 102, 102);
    _lblTag.font = kFONT14;
    
}

@end
