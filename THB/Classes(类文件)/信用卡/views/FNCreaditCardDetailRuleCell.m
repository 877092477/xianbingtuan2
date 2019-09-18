//
//  FNCreaditCardDetailRuleCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardDetailRuleCell.h"

@interface FNCreaditCardDetailRuleCell()

@property (nonatomic, strong) UIView *vContent;

@end

@implementation FNCreaditCardDetailRuleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void) configUI {
    
    _vContent = [[UIView alloc] init];
    [self.contentView addSubview: _vContent];
    [_vContent mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    
    _lblTitle = [[UILabel alloc] init];
    [self.contentView addSubview: _lblTitle];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.vContent).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    _vContent.backgroundColor = RGB(248, 248, 248);
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT14;
    _lblTitle.numberOfLines = 0;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self isShowContent: NO];
}

- (void)isShowContent: (BOOL)isShow {
    _vContent.hidden = !isShow;
}

- (void)setIsLast: (BOOL)isLast {
    [_vContent mas_remakeConstraints: ^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 10, isLast ? 40 : 0, 10));
    }];
}

@end
