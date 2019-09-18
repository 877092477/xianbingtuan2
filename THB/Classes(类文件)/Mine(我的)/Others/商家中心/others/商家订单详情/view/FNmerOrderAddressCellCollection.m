//
//  FNmerOrderAddressCellCollection.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNmerOrderAddressCellCollection.h"

@interface FNmerOrderAddressCellCollection()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UILabel *lblAddress;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UILabel *lblStatus;

@end

@implementation FNmerOrderAddressCellCollection

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    _vContent = [[UIView alloc] init];
    _lblName = [[UILabel alloc] init];
    _lblAddress = [[UILabel alloc] init];
    _lblTime = [[UILabel alloc] init];
    _lblStatus = [[UILabel alloc] init];
    
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_lblName];
    [_vContent addSubview:_lblAddress];
    [_vContent addSubview:_lblTime];
    [_vContent addSubview:_lblStatus];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(@0);
        make.bottom.equalTo(@-10);
    }];
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.right.lessThanOrEqualTo(@-10);
        make.height.mas_equalTo(@15);
    }];
    [_lblAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.lblName.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(@-10);
        make.height.mas_equalTo(@18);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.lblAddress.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(self.lblStatus.mas_left).offset(-10);
        make.height.mas_equalTo(@18);
    }];
    [_lblStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(self.lblTime);
    }];
    
    _vContent.backgroundColor = UIColor.whiteColor;
    _lblName.font = kFONT14;
    _lblName.textColor = RGB(51, 51, 51);
    

    _lblAddress.font = [UIFont boldSystemFontOfSize:18];
    _lblAddress.textColor = RGB(51, 51, 51);

    _lblTime.font = [UIFont boldSystemFontOfSize:16];
    _lblTime.textColor = RGB(51, 51, 51);
    
    _lblStatus.font = kFONT14;
    _lblStatus.textColor = RGB(51, 51, 51);
    
}

-(void)setModel:(FNmerOrderZModel *)model{
    if(model){
        FNtendDetailsBuyMsgModel *buymsgModel=[FNtendDetailsBuyMsgModel mj_objectWithKeyValues:model.buy_msg];
        self.lblName.text=[NSString stringWithFormat:@"%@  %@",buymsgModel.name,buymsgModel.phone];
        self.lblAddress.text=buymsgModel.address;
        self.lblTime.text=@"送达时间";
        
        self.lblStatus.text=buymsgModel.str;
        self.lblStatus.textColor = [UIColor colorWithHexString: buymsgModel.str_color];
    }
}

@end
