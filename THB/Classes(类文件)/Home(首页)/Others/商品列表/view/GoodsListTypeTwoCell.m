//
//  GoodsListTypeTwoCell.m
//  THB
//
//  Created by Fnuo-iOS on 2018/5/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "GoodsListTypeTwoCell.h"

@implementation GoodsListTypeTwoCell

#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentifier = @"GoodsListTypeTwoCell";
    GoodsListTypeTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[GoodsListTypeTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return cell;
}

- (UILabel *)rightLabel{
    if (_rightLabel == nil) {
        _rightLabel = [UILabel new];
        _rightLabel.font = kFONT12;
        _rightLabel.textColor = RED;
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _rightLabel;
}
- (UIButton *)operateBtn{
    if (_operateBtn == nil) {
        _operateBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_operateBtn setImage:IMAGE(@"home_share") forState:(UIControlStateNormal)];
        [_operateBtn sizeToFit];
        _operateBtn.titleLabel.font = kFONT14;
        _operateBtn.userInteractionEnabled = NO;
    }
    return _operateBtn;
}
- (UIView *)rightView{
    if (_rightView == nil) {
        _rightView = [UIView new];
        
        [_rightView addSubview:self.operateBtn];
        [self.operateBtn autoSetDimensionsToSize:(self.operateBtn.size)];
        [self.operateBtn autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        [self.operateBtn autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        @weakify(self);
        [_rightView addJXTouch:^{
            @strongify(self);
            if (self.sharerightNow) {
                self.sharerightNow(self.model);
            }
        }];
        
        [_rightView addSubview:self.rightLabel];
        [self.rightLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [self.rightLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        [self.rightLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.operateBtn withOffset:5];
        
    }
    return _rightView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=FNWhiteColor;
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        
        UIImageView *GoodsImage=[UIImageView new];
        [self addSubview:GoodsImage];
        [GoodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@5);
            make.top.equalTo(@5);
            make.bottom.equalTo(@-5);
            make.width.equalTo(GoodsImage.mas_height);
        }];
        self.GoodsImage=GoodsImage;
        
        UILabel *GoodsName=[UILabel new];
        GoodsName.numberOfLines=2;
        GoodsName.font=kFONT13;
        [self addSubview:GoodsName];
        [GoodsName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(GoodsImage.mas_right).offset(5);
            make.top.equalTo(@5);
            make.right.equalTo(@-5);
        }];
        self.GoodsName=GoodsName;
        
        UILabel *from_sales=[UILabel new];
        from_sales.textColor=FNGlobalTextGrayColor;
        from_sales.font=kFONT11;
        [self addSubview:from_sales];
        
        UILabel *shop_title=[UILabel new];
        shop_title.textColor=FNGlobalTextGrayColor;
        shop_title.font=kFONT11;
        [self addSubview:shop_title];
        
        UILabel *Price=[UILabel new];
        Price.adjustsFontSizeToFitWidth = YES;
        Price.textColor=FNMainGobalTextColor;
        Price.font=kFONT15;
        [self addSubview:Price];
        
        UILabel *OldPrice=[UILabel new];
        OldPrice.adjustsFontSizeToFitWidth = YES;
        OldPrice.textColor=FNGlobalTextGrayColor;
        OldPrice.font=kFONT15;
        [self addSubview:OldPrice];
        
        UILabel *promptPrice=[UILabel new];
        promptPrice.textColor=FNMainGobalTextColor;
        promptPrice.font=kFONT13;
        [self addSubview:promptPrice];
        
        UIImage *quan_bj=IMAGE(@"quan_bj");
        quan_bj=[quan_bj scaleFromImage:quan_bj toSize:CGSizeMake(quan_bj.size.width/quan_bj.size.height*20, 20)];
        UIButton *couponimBtn=[UIButton new];
        couponimBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [couponimBtn setBackgroundImage:quan_bj forState:UIControlStateNormal];
        [couponimBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
        couponimBtn.titleLabel.font=kFONT11;
        [self addSubview:couponimBtn];
        
        [self addSubview:self.rightView];
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(@0);
            make.width.equalTo(@80);
            make.height.equalTo(@50);
        }];
        
        if ([[FNBaseSettingModel settingInstance].app_choujiang_onoff integerValue]==1) {
            [from_sales mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(GoodsImage.mas_right).offset(5);
                make.bottom.equalTo(@-5);
                make.right.equalTo(@-5);
            }];
            
            [shop_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(from_sales.mas_top).offset(-2);
                make.left.equalTo(GoodsImage.mas_right).offset(5);
            }];
            
            [Price mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(shop_title.mas_top).offset(-2);
                make.left.equalTo(GoodsImage.mas_right).offset(5);
            }];
            
            [OldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(Price.mas_top).offset(-5);
                make.left.equalTo(GoodsImage.mas_right).offset(5);
            }];
            
            [couponimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(Price.mas_centerY);
                make.left.equalTo(Price.mas_right).offset(5);
                make.height.equalTo(@20);
                make.width.equalTo(@(quan_bj.size.width));
            }];
            
            [promptPrice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(OldPrice.mas_centerY);
                make.left.equalTo(OldPrice.mas_right).offset(5);
            }];
        }else{
            [Price mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(@-5);
                make.left.equalTo(GoodsImage.mas_right).offset(5);
            }];
            
            [promptPrice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(Price.mas_right).offset(5);
                make.centerY.equalTo(Price.mas_centerY);
            }];
            
            [OldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(Price.mas_top).offset(-5);
                make.left.equalTo(GoodsImage.mas_right).offset(5);
            }];
            
            [couponimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(OldPrice.mas_centerY);
                make.left.equalTo(OldPrice.mas_right).offset(5);
                make.height.equalTo(@20);
                make.width.equalTo(@(quan_bj.size.width));
            }];
            
            [from_sales mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(GoodsImage.mas_right).offset(5);
                make.bottom.equalTo(OldPrice.mas_top).offset(-5);
            }];
            
            [shop_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(GoodsImage.mas_right).offset(5);
                make.bottom.equalTo(from_sales.mas_top).offset(-5);
            }];
        }
        
        self.OldPrice=OldPrice;
        self.couponimBtn=couponimBtn;
        self.Price=Price;
        self.promptPrice=promptPrice;
        self.from_sales=from_sales;
        self.shop_title=shop_title;
        
        if ([FNBaseSettingModel settingInstance].app_sharegoods_onoff.boolValue) {
            self.rightView.hidden=YES;
        }else{
            self.rightView.hidden=NO;
        }
    }
    return self;
}

-(void)setModel:(FNBaseProductModel *)model{
    _model=model;
    if (_model) {
        
        [self.GoodsImage setUrlImg:model.goods_img];
        
        self.GoodsName.text = _model.goods_title;
        [self.GoodsName HttpLabelLeftImage:_model.shop_img label:self.GoodsName imageX:0 imageY:-1.5 imageH:13 atIndex:0];
        
        self.shop_title.text = [NSString stringWithFormat:@"%@",model.shop_title];
        if (model.shop_title.length!=0) {
            UIImage *shopImg=IMAGE(@"detail_shop");
            [self.shop_title addAttchmentImage:shopImg andBounds:CGRectMake(0, -2, 13*shopImg.size.width/shopImg.size.height, 13) atIndex:0];
        }
        
        if (model.provcity.length!=0) {
            self.from_sales.text=[NSString stringWithFormat:@"%@  月销%@",model.provcity,model.goods_sales];
        }else{
            self.from_sales.text=[NSString stringWithFormat:@"月销%@",model.goods_sales];
        }
        
        self.OldPrice.text=[NSString stringWithFormat:@"￥%@",model.goods_cost_price];
        
        [self.couponimBtn setTitle:model.yhq_span forState:UIControlStateNormal];
        
        if (![NSString checkIsSuccess:model.yhq andElement:@"1"]) {
            self.couponimBtn.hidden = YES;
            self.Price.text = [NSString stringWithFormat:@"%@%.2f",[FNBaseSettingModel settingInstance].app_daoshoujia_name,[_model.goods_price floatValue]];
            [self.Price addSingleAttributed:@{NSFontAttributeName:kFONT10} ofRange:[self.Price.text rangeOfString:[FNBaseSettingModel settingInstance].app_daoshoujia_name]];
        }else{
            self.couponimBtn.hidden = NO;
            self.Price.text = [NSString stringWithFormat:@"%@%.2f",[FNBaseSettingModel settingInstance].app_quanhoujia_name,[_model.goods_price floatValue]];
            [self.Price addSingleAttributed:@{NSFontAttributeName:kFONT10} ofRange:[self.Price.text rangeOfString:[FNBaseSettingModel settingInstance].app_quanhoujia_name]];
        }
        
        if ([FNBaseSettingModel settingInstance].app_fanli_onoff.boolValue) {//judge the switch of fan li
            if (_model.is_hide_fl.integerValue==1) {
                self.promptPrice.text=@"";
            }else{
                if ([_model.fcommission floatValue]<=0) {
                    self.promptPrice.text=@"";
                }else{
                    self.promptPrice.text=[NSString stringWithFormat:@" ¥%.2f",[model.fcommission floatValue]];
                    [self.promptPrice HttpLabelLeftImage:model.ico label:self.promptPrice imageX:0 imageY:-3 imageH:15 atIndex:0];
                }
            }
        }else{
            if ([[FNBaseSettingModel settingInstance].app_choujiang_onoff integerValue]==1) {
                self.promptPrice.text=[FNBaseSettingModel settingInstance].app_fanli_off_str;
                [self.promptPrice HttpLabelLeftImage:model.ico label:self.promptPrice imageX:0 imageY:-3 imageH:15 atIndex:0];
            }else{
                self.promptPrice.text=@"";
            }
        }
        
        if ([FNBaseSettingModel settingInstance].all_fx_onoff.boolValue) {
            if (_model.is_hide_sharefl.integerValue==1) {
                _rightLabel.text=[NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].hhrshare_noflstr];
            }else{
                _rightLabel.text=[NSString stringWithFormat:@"%@%@",[FNBaseSettingModel settingInstance].hhrshare_flstr,model.fcommission];
            }
        }else{
            _rightLabel.text=[NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].hhrshare_noflstr];
        }
    }
}

@end
