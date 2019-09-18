//
//  FNmerOrderCheckCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNmerOrderCheckCell.h"
#import "FNtendOrderDetailsDeModel.h"

@interface FNmerOrderCheckCell()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblStatus;
@property (nonatomic, strong) UIImageView *imgRight;

@end

@implementation FNmerOrderCheckCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    _vContent = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblStatus = [[UILabel alloc] init];
    _imgRight = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_lblStatus];
    [_vContent addSubview:_imgRight];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(@0);
        make.bottom.equalTo(@-10);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.lblStatus.mas_left).offset(-10);
        make.height.mas_equalTo(@18);
    }];
    [_lblStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgRight.mas_left).offset(-4);
        make.centerY.equalTo(@0);
    }];
    [_imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(@0);
    }];
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.font = [UIFont boldSystemFontOfSize:16];
    _lblTitle.textColor = RGB(51, 51, 51);
    
    _lblStatus.font = kFONT14;
    _lblStatus.textColor = RGB(51, 51, 51);
    
    _imgRight.image = IMAGE(@"shop_right");
}

-(void)setModel:(FNmerOrderZModel *)model{
    if(model){
        FNtendDetailsBuyMsgModel *buymsgModel=[FNtendDetailsBuyMsgModel mj_objectWithKeyValues:model.buy_msg];

        self.lblTitle.text=@"商品二维码";
        
        self.lblStatus.text=buymsgModel.str;
        self.lblStatus.textColor = [UIColor colorWithHexString: buymsgModel.str_color];
    }
}

@end
