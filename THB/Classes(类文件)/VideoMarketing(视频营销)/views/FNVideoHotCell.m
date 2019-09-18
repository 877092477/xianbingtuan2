//
//  FNVideoHotCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoHotCell.h"

@interface FNVideoHotCell()



@end

@implementation FNVideoHotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.whiteColor;
    
    _imgHeader = [[UIImageView alloc] init];;
    _lblTitle = [[UILabel alloc] init];;
    _lblDesc = [[UILabel alloc] init];;
    _lblActor = [[UILabel alloc] init];;
    _lblHot = [[UILabel alloc] init];;
    
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblDesc];
    [self.contentView addSubview:_lblActor];
    [self.contentView addSubview:_lblHot];
    
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.equalTo(@13);
        make.bottom.equalTo(@-5);
        make.width.equalTo(self.imgHeader.mas_height).multipliedBy(0.75);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.right.lessThanOrEqualTo(@-13);
        make.top.equalTo(self.imgHeader).offset(4);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.right.lessThanOrEqualTo(@-13);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(8);
    }];
    [_lblActor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.right.lessThanOrEqualTo(@-13);
        make.top.equalTo(self.lblDesc.mas_bottom).offset(8);
    }];
    [_lblHot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(10);
        make.right.lessThanOrEqualTo(@-13);
        make.bottom.equalTo(self.imgHeader.mas_bottom).offset(-4);
    }];
    
    _imgHeader.contentMode = UIViewContentModeScaleAspectFill;
    _imgHeader.layer.masksToBounds = YES;
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT15;
    
    _lblDesc.textColor = RGB(153, 153, 153);
    _lblDesc.font = kFONT14;
    
    _lblActor.textColor = RGB(153, 153, 153);
    _lblActor.font = kFONT14;
    
    _lblHot.textColor = RGB(153, 153, 153);
    _lblHot.font = kFONT12;
}

@end
