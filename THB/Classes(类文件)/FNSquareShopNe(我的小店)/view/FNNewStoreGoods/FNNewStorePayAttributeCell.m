//
//  FNNewStorePayAttributeCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/31.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStorePayAttributeCell.h"

@interface FNNewStorePayAttributeCell()

@property (nonatomic, strong) UIView *vBorder;


@end

@implementation FNNewStorePayAttributeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void) configUI {
    _vBorder = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    
    [self.contentView addSubview:_vBorder];
    [self.contentView addSubview:_lblTitle];
    
    [_vBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@-17);
        make.height.mas_equalTo(26);
        make.centerY.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(@10);
        //        make.right.equalTo(@-10);
        make.center.equalTo(self.vBorder);
    }];
    
    [self setIsSelected:NO];
}

- (void)setIsSelected: (BOOL)isSelected {
    if (!isSelected) {
        _vBorder.layer.cornerRadius = 4;
        _vBorder.layer.borderWidth = 1;
        _vBorder.layer.borderColor = RGB(240, 240, 240).CGColor;
        _vBorder.layer.backgroundColor = RGB(240, 240, 240).CGColor;
        
        _lblTitle.font = kFONT12;
        _lblTitle.textColor = RGB(153, 153, 153);
    } else {
        _vBorder.layer.cornerRadius = 4;
        _vBorder.layer.borderWidth = 1;
        _vBorder.layer.borderColor = RGB(242, 58, 77).CGColor;
        _vBorder.layer.backgroundColor = RGB(242, 58, 77).CGColor;
        
        _lblTitle.font = kFONT13;
        _lblTitle.textColor = UIColor.whiteColor;
    }
}

- (void)setDisable {
    _vBorder.layer.cornerRadius = 4;
    _vBorder.layer.borderWidth = 1;
    _vBorder.layer.borderColor = RGB(250, 250, 250).CGColor;
    _vBorder.layer.backgroundColor = RGB(250, 250, 250).CGColor;
    
    _lblTitle.font = kFONT12;
    _lblTitle.textColor = RGB(200, 200, 200);
}

@end
