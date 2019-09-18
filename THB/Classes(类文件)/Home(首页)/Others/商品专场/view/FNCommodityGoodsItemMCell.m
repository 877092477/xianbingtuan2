//
//  FNCommodityGoodsItemMCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCommodityGoodsItemMCell.h"

@implementation FNCommodityGoodsItemMCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNCommodityGoodsItemMCellID";
    FNCommodityGoodsItemMCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) { 
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews{
    self.bgImgView=[[UIImageView alloc]init];
    self.bgImgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgImgView];
    self.bgImgView.borderWidth=1.5;
    self.bgImgView.borderColor = RGB(250, 242, 242);
    self.bgImgView.cornerRadius=10;
    self.bgImgView.clipsToBounds = YES;
    
    self.topImgView=[[UIImageView alloc]init]; 
    [self.bgImgView addSubview:self.topImgView];
    
    self.typeImgView=[[UIImageView alloc]init];
    [self addSubview:self.typeImgView];
    
    self.nameLB=[[UILabel alloc]init];
    self.priceLB=[[UILabel alloc]init];
    self.originalPriceLB=[[UILabel alloc]init];
    self.salesLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    [self addSubview:self.priceLB];
    [self addSubview:self.originalPriceLB];
    [self addSubview:self.salesLB]; 
    
    self.ticketBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.ticketBtn];
    self.prospectBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.prospectBtn];
    self.shareBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.shareBtn];
    
    self.ticketBtn.titleLabel.font=kFONT10;
    self.prospectBtn.titleLabel.font=kFONT10;
    self.shareBtn.titleLabel.font=kFONT11;
    
    self.nameLB.font=[UIFont systemFontOfSize:12];
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.priceLB.font=[UIFont systemFontOfSize:10];//[UIFont fontWithName:@"Copperplate-Light" size:10];//[UIFont systemFontOfSize:12];
    self.priceLB.textColor=RGB(254, 67, 62);
    self.priceLB.textAlignment=NSTextAlignmentLeft;
    
    self.originalPriceLB.font=[UIFont systemFontOfSize:10];//[UIFont fontWithName:@"MarkPro-Bold" size:10];
    self.originalPriceLB.textColor=RGB(153, 153, 153);
    self.originalPriceLB.textAlignment=NSTextAlignmentRight;
    
    self.salesLB.font=[UIFont systemFontOfSize:10];
    self.salesLB.textColor=RGB(153, 153, 153);
    self.salesLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 2.5).topSpaceToView(self,5).bottomSpaceToView(self, 0).rightSpaceToView(self, 2.5);
    
    self.topImgView.sd_layout
    .leftSpaceToView(self.bgImgView, 0).topSpaceToView(self.bgImgView, 0).heightIs(175).rightSpaceToView(self.bgImgView, 0);
    
    CGFloat with= (FNDeviceWidth-10-5)/2;
    self.topImgView.frame=CGRectMake(0, 0, with, 175);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.topImgView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.topImgView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.topImgView.layer.mask = maskLayer; 
    
    self.typeImgView.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self, 185).widthIs(14).heightIs(14);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.typeImgView, 5).heightIs(18).rightSpaceToView(self, 10).centerYEqualToView(self.typeImgView);
    
    self.priceLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self.typeImgView, 35).heightIs(21).widthIs(80);
    
    self.originalPriceLB.sd_layout
    .topSpaceToView(self.typeImgView, 35).heightIs(21).rightSpaceToView(self, 10).widthIs(35);
    
    self.ticketBtn.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self.typeImgView, 12).heightIs(15).widthIs(30);
    
    self.prospectBtn.sd_layout
    .leftSpaceToView(self, 55).topSpaceToView(self.typeImgView, 12).heightIs(15).widthIs(37);
    
    self.salesLB.sd_layout
    .leftSpaceToView(self, 15).bottomSpaceToView(self, 17).heightIs(16).rightSpaceToView(self, 60);
    
    self.shareBtn.sd_layout
    .bottomSpaceToView(self, 15).heightIs(17).rightSpaceToView(self, 10).widthIs(35);
    
    
    
    [self.shareBtn addTarget:self action:@selector(shareBtnMethod)];
}

-(void)setModel:(FNBaseProductModel *)model{
    _model=model;
    if(model){
        if([model.shadow_color kr_isNotEmpty]){
           self.bgImgView.borderColor = [UIColor colorWithHexString:model.shadow_color];
        }
        [self.topImgView setUrlImg:model.goods_img];
        
        [self.typeImgView setUrlImg:model.shop_img];
        [self.shareBtn sd_setBackgroundImageWithURL:URL(model.share_img) forState:UIControlStateNormal];
        [self.ticketBtn sd_setBackgroundImageWithURL:URL(model.goods_quanbj_bjimg) forState:UIControlStateNormal];
        [self.prospectBtn sd_setBackgroundImageWithURL:URL(model.goods_fanli_bjimg) forState:UIControlStateNormal];
        
        [self.ticketBtn setTitle:model.yhq_span forState:UIControlStateNormal];
        [self.ticketBtn setTitleColor:[UIColor colorWithHexString:model.goodsyhqstr_color] forState:UIControlStateNormal];
        [self.prospectBtn setTitleColor:[UIColor colorWithHexString:model.goodsfcommissionstr_color] forState:UIControlStateNormal];
        
        
        
        //返利样式
        NSInteger goods_flstyle=[[FNBaseSettingModel settingInstance].goods_flstyle integerValue];
        if (goods_flstyle==0 || goods_flstyle==1) {
            self.salesLB.text=[NSString stringWithFormat:@"热销 %@",model.goods_sales];
        }else{
            self.salesLB.text=[NSString stringWithFormat:@"%@人已买",model.goods_sales];
        }
        
        if([model.fxz kr_isNotEmpty]){
            if ([model.is_hide_sharefl isEqualToString:@"1"]) {
                self.shareBtn.hidden = YES;
            }else{
                self.shareBtn.hidden = NO;
            }
        }else{
            self.shareBtn.hidden = YES;
        }
        NSString *qhjStr=@"";
        NSInteger yhqState=0;
        //判断优惠券,没有就隐藏
        if ([model.yhq_span kr_isNotEmpty]&&![model.yhq_price isEqualToString:@"0"]) {
            yhqState=1;
            self.ticketBtn.hidden = NO;
            qhjStr=[NSString stringWithFormat:@"%@¥",[FNBaseSettingModel settingInstance].app_quanhoujia_name];
        }else{
            yhqState=0;
            self.ticketBtn.hidden = YES;
            qhjStr=[NSString stringWithFormat:@"%@¥",[FNBaseSettingModel settingInstance].app_daoshoujia_name];
            //显示到手价标题
        }
        
        CGFloat goodsPriceFloat=[model.goods_price floatValue];
        
        NSString *price=[NSString stringWithFormat:@"%.2f",goodsPriceFloat];
        
        NSString *jointPrice=[NSString stringWithFormat:@"%@%@",qhjStr,price];
        
        NSString *originalPrice=[NSString stringWithFormat:@"¥%@",model.goods_cost_price];
        
        CGFloat fcommissionFloat=[model.fcommission floatValue];
        
        NSString *fanliStr=[NSString stringWithFormat:@"%@%.2f",model.fan_all_str,fcommissionFloat];
        
        NSString *quanStr=[NSString stringWithFormat:@"券%@",model.yhq_span];
        
        [self.ticketBtn setTitle:quanStr forState:UIControlStateNormal];
        
        self.nameLB.text=model.goods_title;
        self.priceLB.text=jointPrice;
        self.originalPriceLB.text=[NSString stringWithFormat:@"¥%@",model.goods_cost_price];
        
        CGFloat priceLBW=[jointPrice kr_getWidthWithTextHeight:21 font:20];
        if(priceLBW>120){
            priceLBW=120;
        }
        CGFloat originalPriceLBW=[originalPrice kr_getWidthWithTextHeight:21 font:14];
        if(originalPriceLBW>80){
            originalPriceLBW=80;
        }
        
        CGFloat btnwWith= (FNDeviceWidth-10-5-15-15)/4;
        
        CGFloat yhqW=[quanStr kr_getWidthWithTextHeight:15 font:11];
        if(yhqW>btnwWith){
            yhqW=btnwWith;
        }
        CGFloat fanliW=[fanliStr kr_getWidthWithTextHeight:15 font:11];
        if(fanliW>btnwWith){
            fanliW=btnwWith;
        }
        
        self.priceLB.sd_layout
        .leftSpaceToView(self, 15).topSpaceToView(self.typeImgView, 35).heightIs(21).widthIs(priceLBW);
        
        self.originalPriceLB.sd_layout
        .topSpaceToView(self.typeImgView, 33).heightIs(25).rightSpaceToView(self, 10).widthIs(originalPriceLBW);
        
        if([model.goods_price kr_isNotEmpty]){
            //[self.priceLB fn_changeColorWithTextColor:RGB(153, 153, 153) changeText:model.goods_cost_price];
            [self.priceLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:10] changeText:qhjStr];
            [self.priceLB fn_changeFontWithTextFont:[UIFont fontWithName:@"MarkPro-Bold" size:18] changeText:price];
        }
        [self.originalPriceLB fn_changeStrikethroughStyleWithTextStrikethroughStyle:@(NSUnderlineStyleSingle) changeText:originalPrice];
        [self.originalPriceLB fn_changeStrikethroughColorWithTextStrikethroughColor:RGB(153, 153, 153) changeText:originalPrice];
        
        self.ticketBtn.sd_layout
        .leftSpaceToView(self, 15).topSpaceToView(self.typeImgView, 12).heightIs(15).widthIs(yhqW+5);
        
        CGFloat favourBtnLeftGap=yhqW+5+10;
        
        //判断模式
        if([FNBaseSettingModel settingInstance].app_choujiang_onoff.boolValue){//判断是否是抽奖模式
            self.prospectBtn.hidden = YES;
            //[NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].app_fanli_off_str];//抽奖模式文字
        }else{
            // goods_flstyle:0.有返利样式，1.无返利样式
            if (goods_flstyle == 0) {
                if ([model.fcommission kr_isNotEmpty]&&![model.fcommission isEqualToString:@"0"]) {
                    if ([model.is_hide_fl isEqualToString:@"1"]) {
                        self.prospectBtn.hidden = YES;
                    }else{
                        self.prospectBtn.hidden = NO;
                        
                        [self.prospectBtn setTitle:fanliStr forState:UIControlStateNormal];
                        if(yhqState==1){
                            favourBtnLeftGap=15+yhqW+5+5;
                        }else{
                            favourBtnLeftGap=15;
                        }
                        
                        self.prospectBtn.sd_layout
                        .leftSpaceToView(self, favourBtnLeftGap).topSpaceToView(self.typeImgView, 12).heightIs(15).widthIs(fanliW+5);
                    }
                }else{
                    self.prospectBtn.hidden = YES;
                }
            }else{
                self.prospectBtn.hidden = YES;
            }
        }
        
        if([quanStr kr_isNotEmpty]){
            [self.ticketBtn.titleLabel fn_changeFontWithTextFont:[UIFont fontWithName:@"MarkPro-Bold" size:10] changeText:quanStr];
        }
        
        if([fanliStr kr_isNotEmpty]){
            [self.prospectBtn.titleLabel fn_changeFontWithTextFont:[UIFont fontWithName:@"MarkPro-Bold" size:10] changeText:fanliStr];
        }
    }
}
//分享点击方法
-(void)shareBtnMethod{ 
    if (self.sharerightNow) {
        self.sharerightNow(self.model);
    }
}
@end
