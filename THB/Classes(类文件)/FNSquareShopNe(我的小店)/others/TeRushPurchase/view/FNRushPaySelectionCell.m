//
//  FNRushPaySelectionCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/1.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNRushPaySelectionCell.h"


@interface FNRushPaySelectionCell()

@property (nonatomic, strong) UIView *vContent;

@end

@implementation FNRushPaySelectionCell

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
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _imgRight = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_lblDesc];
    [_vContent addSubview:_imgRight];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.bottom.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.lblDesc).offset(-20);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgRight.mas_left).offset(-10);
        make.centerY.equalTo(@0);
    }];
    [_imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(@0);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.textColor = RGB(60, 60, 60);
    _lblTitle.font = kFONT15;
    
    _lblDesc.textColor = RGB(1, 172, 243);
    _lblDesc.font = kFONT13;
    
    _imgRight.image = IMAGE(@"FJ_minRight_img");
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
