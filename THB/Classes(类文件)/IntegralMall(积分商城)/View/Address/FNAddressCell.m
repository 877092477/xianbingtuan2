//
//  FNAddressCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNAddressCell.h"

@interface FNAddressCell()

@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UILabel *lblPhone;
@property (nonatomic, strong) UIView *vDefault;
@property (nonatomic, strong) UILabel *lblDefault;
@property (nonatomic, strong) UIView *vTag;
@property (nonatomic, strong) UILabel *lblTag;
@property (nonatomic, strong) UILabel *lblAddress;
@property (nonatomic, strong) UIButton *btnEdit;
@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void) configUI {
    self.lblName = [[UILabel alloc] init];
    self.lblPhone = [[UILabel alloc] init];
    self.vDefault = [[UIView alloc] init];
    self.lblDefault = [[UILabel alloc] init];
    self.vTag = [[UIView alloc] init];
    self.lblTag = [[UILabel alloc] init];
    self.lblAddress = [[UILabel alloc] init];
    self.btnEdit = [[UIButton alloc] init];
    self.vLine = [[UILabel alloc] init];
    
    [self.contentView addSubview:self.lblName];
    [self.contentView addSubview:self.lblPhone];
    [self.contentView addSubview:self.vDefault];
    [self.vDefault addSubview:self.lblDefault];
    [self.contentView addSubview:self.vTag];
    [self.vTag addSubview:self.lblTag];
    [self.contentView addSubview:self.lblAddress];
    [self.contentView addSubview:self.btnEdit];
    [self.contentView addSubview:self.vLine];
    
    [self.lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@15);
    }];
    [self.lblPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblName.mas_right).offset(20);
        make.centerY.equalTo(self.lblName);
    }];
    [self.vDefault mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPhone.mas_right).offset(10);
        make.centerY.equalTo(self.lblName);
        make.height.mas_equalTo(@14);
    }];
    [self.lblDefault mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.right.equalTo(@-8);
        make.centerY.equalTo(@0);
    }];
    [self.vTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vDefault.mas_right).offset(2);
        make.centerY.equalTo(self.lblName);
        make.height.mas_equalTo(@14);
    }];
    [self.lblTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.right.equalTo(@-8);
        make.centerY.equalTo(@0);
    }];
    [self.lblAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(_lblName.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(self.btnEdit.mas_left).offset(-40);
        make.bottom.equalTo(@-15);
    }];
    [self.btnEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.centerY.equalTo(@0);
    }];
    [self.vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.lblName.textColor = RGB(60, 60, 60);
    self.lblName.font = [UIFont boldSystemFontOfSize:15];
    
    self.lblPhone.textColor = RGB(60, 60, 60);
    self.lblPhone.font = kFONT14;
    
    self.lblDefault.textColor = UIColor.whiteColor;
    self.lblDefault.font = kFONT10;
    
    self.lblTag.textColor = UIColor.whiteColor;
    self.lblTag.font = kFONT10;
    
    self.lblAddress.textColor = RGB(60, 60, 60);
    self.lblAddress.font = kFONT12;
    self.lblAddress.numberOfLines = 0;
    
    [self.btnEdit setImage:IMAGE(@"address_image_edit") forState:UIControlStateNormal];
    [self.btnEdit addTarget:self action:@selector(onEditClick)];
    
    self.vDefault.backgroundColor = RGB(255, 37, 37);
    self.vDefault.cornerRadius = 7;
    
    self.lblDefault.text = @"默认";
    
    self.vTag.backgroundColor = RGB(255, 131, 20);
    self.vTag.cornerRadius = 7;
    
    self.vLine.backgroundColor = FNHomeBackgroundColor;
    
}

- (void) setName: (NSString*)name withPhone: (NSString*)phone tag: (NSString*)tag address: (NSString*)address isDefault: (BOOL) isDefault {
    self.lblName.text = name;
    self.lblPhone.text = phone;
    self.lblTag.text = tag;
    self.lblAddress.text = address;
    [self.vTag setHidden:[tag isEqualToString:@""]];
    [self.vDefault setHidden:!isDefault];
    [self.vTag mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (isDefault)
            make.left.equalTo(self.vDefault.mas_right).offset(2);
        else
            make.left.equalTo(self.lblPhone.mas_right).offset(2);
        make.centerY.equalTo(self.lblName);
        make.height.mas_equalTo(@14);
    }];
}

#pragma mark - Action

- (void)onEditClick {
    if ([_delegate respondsToSelector:@selector(didEditClick:)]) {
        [_delegate didEditClick:self];
    }
}

@end
