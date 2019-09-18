//
//  GoodsListTypeOneCell.m
//  THB
//
//  Created by Fnuo-iOS on 2018/5/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "GoodsListTypeOneCell.h"

@implementation GoodsListTypeOneCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"GoodsListTypeOneCell";
    GoodsListTypeOneCell *cell = (GoodsListTypeOneCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor=FNWhiteColor;
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UIImageView *GoodsImage=[UIImageView new];
        [self addSubview:GoodsImage];
        [GoodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
            make.height.equalTo(GoodsImage.mas_width);
        }];
        self.GoodsImage=GoodsImage;
        
        UILabel *GoodsName=[UILabel new];
        GoodsName.numberOfLines=2;
        GoodsName.font=kFONT13;
        [self addSubview:GoodsName];
        [GoodsName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(GoodsImage.mas_bottom).offset(0);
            make.left.equalTo(@5);
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
        
        UIImage *quan_bj=IMAGE(@"quan_bj");
        quan_bj=[quan_bj scaleFromImage:quan_bj toSize:CGSizeMake(quan_bj.size.width/quan_bj.size.height*20, 20)];
        
        UILabel *OldPrice=[UILabel new];
        OldPrice.adjustsFontSizeToFitWidth = YES;
        OldPrice.textColor=FNGlobalTextGrayColor;
        OldPrice.font=kFONT15;
        [self addSubview:OldPrice];
        
        UILabel *promptPrice=[UILabel new];
        promptPrice.textColor=FNMainGobalTextColor;
        promptPrice.font=kFONT13;
        [self addSubview:promptPrice];
        
        UIButton *couponimBtn=[UIButton new];
        couponimBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [couponimBtn setBackgroundImage:quan_bj forState:UIControlStateNormal];
        [couponimBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
        couponimBtn.titleLabel.font=kFONT11;
        [self addSubview:couponimBtn];
        
        if ([[FNBaseSettingModel settingInstance].app_choujiang_onoff integerValue]==1) {
            [from_sales mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(@-5);
                make.left.equalTo(@5);
                make.right.equalTo(@-5);
            }];
            
            [shop_title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(from_sales.mas_top).offset(-3);
                make.left.equalTo(@5);
            }];
            
            [Price mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(shop_title.mas_top).offset(-5);
                make.left.equalTo(@5);
            }];
            
            [OldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(Price.mas_top).offset(0);
                make.left.equalTo(@5);
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
                make.left.equalTo(@5);
            }];
            
            [promptPrice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(Price.mas_centerY);
                make.left.equalTo(Price.mas_right).offset(5);
            }];
            
            [shop_title mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.bottom.equalTo(Price.mas_top).offset(-3);
                make.left.equalTo(@5);
            }];
            
            [from_sales mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(shop_title.mas_top).offset(-3);
                make.left.equalTo(@5);
            }];
            
            [OldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(from_sales.mas_top).offset(-5);
                make.left.equalTo(@5);
            }];
            
            [couponimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(OldPrice.mas_centerY);
                make.left.equalTo(OldPrice.mas_right).offset(5);
                make.height.equalTo(@20);
                make.width.equalTo(@(quan_bj.size.width));
            }];
        }
        
        self.from_sales=from_sales;
        self.Price=Price;
        self.promptPrice=promptPrice;
        self.OldPrice=OldPrice;
        self.couponimBtn=couponimBtn;
        self.shop_title=shop_title;
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
    }
}

@end
