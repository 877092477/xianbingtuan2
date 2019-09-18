//
//  FNteIndentQrcodeNeCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/7.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNteIndentQrcodeNeCell.h"

#import "FNrushPurchaseNeModel.h"
#import "FNtendOrderDetailsDeModel.h"

@interface FNteIndentQrcodeNeCell()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblState;
@property (nonatomic, strong) UIImageView *imgQrcode;
@property (nonatomic, strong) UILabel *lblCode;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UIView *vLine;

@end

@implementation FNteIndentQrcodeNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    _vContent = [[UIView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblState = [[UILabel alloc] init];
    _imgQrcode = [[UIImageView alloc] init];
    _lblCode = [[UILabel alloc] init];
    _lblTime = [[UILabel alloc] init];
    _vLine = [[UIView alloc] init];
    
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_lblTitle];
    [_vContent addSubview:_lblState];
    [_vContent addSubview:_imgQrcode];
    [_vContent addSubview:_lblCode];
    [_vContent addSubview:_lblTime];
    [_vContent addSubview:_vLine];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(0, 10, 10, 10));
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.top.equalTo(@15);
        make.right.lessThanOrEqualTo(self.lblState.mas_left).offset(-20);
    }];
    [_lblState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-12);
        make.top.equalTo(@15);
    }];
    [_imgQrcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom).offset(15);
        make.centerX.equalTo(@0);
        make.width.height.mas_equalTo(140);
    }];
    [_lblCode mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.imgQrcode.mas_bottom).offset(21);
        make.bottom.equalTo(@-20);
        make.left.greaterThanOrEqualTo(@12);
        make.right.lessThanOrEqualTo(@-12);
        make.centerX.equalTo(@0);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblCode.mas_bottom).offset(6);
        make.left.greaterThanOrEqualTo(@12);
        make.right.lessThanOrEqualTo(@-12);
        make.centerX.equalTo(@0);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@46);
        make.left.equalTo(@12);
        make.right.equalTo(@-12);
        make.height.mas_equalTo(1);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.vContent.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.textColor = RGB(60, 60, 60);
    _lblTitle.font = [UIFont boldSystemFontOfSize:15];
    _lblTitle.text = @"商品二维码";
    
    _lblState.font = kFONT14;
    _lblState.textColor = RGB(244, 47, 25);
    
    _lblCode.textColor = RGB(140, 140, 140);
    _lblCode.font = kFONT14;
    
    _lblTime.textColor = RGB(153, 153, 153);
    _lblTime.font = kFONT11;
    
    _vLine.backgroundColor = RGB(245, 245, 245);
}

-(void)setModel:(FNtendOrderDetailsDeModel *)model{

    FNrushBuyMsgModel *buyModel=[FNrushBuyMsgModel mj_objectWithKeyValues:model.buy_msg];
    _vContent.hidden = ![buyModel.code kr_isNotEmpty];
    _lblState.text = buyModel.str;
    [_imgQrcode sd_setImageWithURL: URL(buyModel.qr_code)];
    
    if ([model.t isEqualToString:@"2"]) {
        _imgQrcode.hidden = NO;
        _lblCode.text = [NSString stringWithFormat:@"消费码：%@", buyModel.code];
    } else {
        _imgQrcode.hidden = YES;
        _lblCode.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"消费码：%@",buyModel.code] attributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle)}];
    }
}

@end
