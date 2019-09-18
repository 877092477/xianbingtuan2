//
//  FNNewStoreCouponeAlertCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/26.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreCouponeAlertCell.h"

@interface FNNewStoreCouponeAlertCell()

@property (nonatomic, strong) UIImageView *imgCoupone;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblCondition;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UILabel *lblAccept;

@end

@implementation FNNewStoreCouponeAlertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _imgCoupone = [[UIImageView alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _lblCondition = [[UILabel alloc] init];
    _lblTime = [[UILabel alloc] init];
    _lblAccept = [[UILabel alloc] init];
    
    [self.contentView addSubview:_imgCoupone];
    [self.contentView addSubview:_lblPrice];
    [self.contentView addSubview:_lblCondition];
    [self.contentView addSubview:_lblTime];
    [self.contentView addSubview:_lblAccept];
    
    UIView *vLeft = [[UIView alloc] init];
    UIView *vRight = [[UIView alloc] init];
    [self.contentView addSubview:vLeft];
    [self.contentView addSubview:vRight];
    
    [_imgCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [vLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(self.lblPrice);
        make.height.mas_equalTo(5);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vLeft.mas_right);
        make.top.equalTo(@26);
//        make.width.mas_equalTo(100);
    }];
    [vRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPrice.mas_right);
        make.centerY.equalTo(self.lblPrice);
        make.height.mas_equalTo(5);
        make.width.equalTo(vLeft);
    }];
    [_lblCondition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vRight.mas_right).offset(4);
        make.right.equalTo(self.contentView.mas_centerX).offset(10);
        make.centerY.equalTo(self.lblPrice);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(self.lblPrice.mas_bottom).offset(10);
    }];
    [_lblAccept mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.centerX.equalTo(@0).offset(100);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _lblPrice.font = [UIFont boldSystemFontOfSize:18];
    _lblCondition.font = kFONT12;
    _lblTime.font = kFONT10;
    _lblAccept.font = [UIFont boldSystemFontOfSize:16];
}

- (void)setModel: (FNstoreCouponeModel*) model {
    _lblPrice.textColor = [UIColor colorWithHexString: model.color];
    _lblCondition.textColor = [UIColor colorWithHexString: model.color];
    _lblTime.textColor = [UIColor colorWithHexString: model.color];
    _lblAccept.textColor = [UIColor colorWithHexString: model.color];
    
    [_imgCoupone sd_setImageWithURL: URL(model.bj_img)];
    
    _lblPrice.text = model.money_str;
    _lblCondition.text = model.str;
    _lblTime.text = model.date;
    _lblAccept.text = model.btn;
}

@end
