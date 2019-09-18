//
//  FNNewStoreCommentQuestionCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/6.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreCommentQuestionCell.h"

@interface FNNewStoreCommentQuestionCell()

@property (nonatomic, strong) UIView *radiuBorder;
@property (nonatomic, strong) UIView *radiuPoint;
@end

@implementation FNNewStoreCommentQuestionCell

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
    _radiuBorder = [[UIView alloc] init];
    _radiuPoint = [[UIView alloc] init];
    
    [self.contentView addSubview: _lblTitle];
    [self.contentView addSubview: _radiuBorder];
    [_radiuBorder addSubview: _radiuPoint];

    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.radiuBorder.mas_left).offset(-15);
    }];
    [_radiuBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(@-15);
        make.width.height.mas_equalTo(14);
    }];
    [_radiuPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.height.mas_equalTo(10);
    }];
    
    _lblTitle.font = kFONT13;
    
    _radiuBorder.cornerRadius = 7;
    _radiuBorder.layer.borderWidth = 1;
    
    _radiuPoint.cornerRadius = 5;
    
    _radiuPoint.backgroundColor = RGB(242, 58, 77);
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    _radiuBorder.layer.borderColor = (selected ? RGB(242, 58, 77) : RGB(200, 200, 200)).CGColor;
//    _radiuBorder.backgroundColor = selected ? RGB(242, 58, 77) : RGB(200, 200, 200);
    _radiuPoint.hidden = !selected;
}

@end
