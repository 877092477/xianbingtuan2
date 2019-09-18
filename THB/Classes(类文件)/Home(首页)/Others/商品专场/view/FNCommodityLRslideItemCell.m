//
//  FNCommodityLRslideItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCommodityLRslideItemCell.h"

@implementation FNCommodityLRslideItemCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNCommodityLRslideItemCellID";
    FNCommodityLRslideItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgImgView=[[UIImageView alloc]init];
    self.bgImgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgImgView];
    self.bgImgView.borderWidth=1.5;
    self.bgImgView.borderColor = RGB(250, 242, 242);
    self.bgImgView.cornerRadius=10;
    self.bgImgView.clipsToBounds = YES;
    
    self.imgView=[[UIImageView alloc]init];
    [self.bgImgView addSubview:self.imgView];
    
    self.hotImgView=[[UIImageView alloc]init];
    [self addSubview:self.hotImgView];
    
    self.typeImgView=[[UIImageView alloc]init];
    [self addSubview:self.typeImgView];
    
    self.titleLB=[[UILabel alloc]init];
    self.nameLB=[[UILabel alloc]init];
    self.priceLB=[[UILabel alloc]init];
    self.originalPriceLB=[[UILabel alloc]init];
    self.salesLB=[[UILabel alloc]init];
    
    [self addSubview:self.titleLB];
    [self addSubview:self.nameLB];
    [self addSubview:self.priceLB];
    [self addSubview:self.originalPriceLB];
    [self addSubview:self.salesLB]; 
    
    self.archBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.favourBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [self addSubview:self.archBtn];
    [self addSubview:self.favourBtn];
    [self addSubview:self.shareBtn];
    
    self.titleLB.font=[UIFont systemFontOfSize:18];
    self.titleLB.textColor=RGB(255, 50, 63);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.nameLB.font=[UIFont systemFontOfSize:14];
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.priceLB.font=[UIFont systemFontOfSize:10];//[UIFont fontWithName:@"Copperplate-Light" size:10];//[UIFont systemFontOfSize:12];
    self.priceLB.textColor=RGB(254, 67, 62);
    self.priceLB.textAlignment=NSTextAlignmentLeft;
    
    self.originalPriceLB.font=[UIFont systemFontOfSize:12];//[UIFont fontWithName:@"MarkPro-Bold" size:12];
    self.originalPriceLB.textColor=RGB(153, 153, 153);
    self.originalPriceLB.textAlignment=NSTextAlignmentRight;
    
    self.salesLB.font=[UIFont systemFontOfSize:12];
    self.salesLB.textColor=RGB(153, 153, 153);
    self.salesLB.textAlignment=NSTextAlignmentLeft;
    
    self.archBtn.titleLabel.font=kFONT11;
    [self.archBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.favourBtn.titleLabel.font=kFONT11;
    [self.favourBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.shareBtn.titleLabel.font=kFONT11;
    [self.shareBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.imgView.sd_layout
    .leftSpaceToView(self.bgImgView, 0).topSpaceToView(self.bgImgView, 0).heightIs(175).widthIs(175);
    
    self.imgView.frame=CGRectMake(0, 0, 175, 175);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.imgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.imgView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.imgView.layer.mask = maskLayer;
    
    self.hotImgView.sd_layout
    .leftSpaceToView(self, 185).topSpaceToView(self, 22).widthIs(15).heightIs(18);
    
    self.typeImgView.sd_layout
    .leftSpaceToView(self, 185).topSpaceToView(self.hotImgView, 15).widthIs(16).heightIs(16);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.hotImgView, 5).centerYEqualToView(self.hotImgView).heightIs(22).rightSpaceToView(self, 5);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.typeImgView, 5).centerYEqualToView(self.typeImgView).heightIs(18).rightSpaceToView(self, 5);
    
    self.archBtn.sd_layout
    .leftSpaceToView(self, 185).topSpaceToView(self.typeImgView, 17).heightIs(15).widthIs(30);
    
    self.favourBtn.sd_layout
    .leftSpaceToView(self, 210).topSpaceToView(self.typeImgView, 17).heightIs(15).widthIs(37);
    
    self.priceLB.sd_layout
    .leftSpaceToView(self, 187).topSpaceToView(self.typeImgView, 40).heightIs(22).widthIs(130);
    
    self.originalPriceLB.sd_layout
    .topSpaceToView(self.typeImgView, 40).heightIs(22).rightSpaceToView(self, 12).widthIs(90);
    
    self.salesLB.sd_layout
    .leftSpaceToView(self, 185).bottomSpaceToView(self, 18).heightIs(15).rightSpaceToView(self, 50);
    
    self.shareBtn.sd_layout
    .bottomSpaceToView(self, 11).heightIs(17).rightSpaceToView(self, 10).widthIs(35);
    
    [self.shareBtn addTarget:self action:@selector(shareBtnMethod)];
}

-(void)setModel:(FNBaseProductModel *)model{
    _model=model;
    if(model){
        self.bgImgView.borderColor = [UIColor colorWithHexString:model.shadow_color];
        [self.imgView setUrlImg:model.goods_img];
        [self.hotImgView setUrlImg:model.hot_img];
        [self.typeImgView setUrlImg:model.shop_img];
        [self.shareBtn sd_setBackgroundImageWithURL:URL(model.share_img) forState:UIControlStateNormal];
        [self.archBtn sd_setBackgroundImageWithURL:URL(model.goods_quanbj_bjimg) forState:UIControlStateNormal];
        [self.favourBtn sd_setBackgroundImageWithURL:URL(model.goods_fanli_bjimg) forState:UIControlStateNormal];
        
        [self.archBtn setTitle:model.yhq_span forState:UIControlStateNormal];
        [self.archBtn setTitleColor:[UIColor colorWithHexString:model.goodsyhqstr_color] forState:UIControlStateNormal];
        [self.favourBtn setTitleColor:[UIColor colorWithHexString:model.goodsfcommissionstr_color] forState:UIControlStateNormal];
        
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
            self.archBtn.hidden = NO;
            qhjStr=[NSString stringWithFormat:@"%@¥",[FNBaseSettingModel settingInstance].app_quanhoujia_name];
        }else{
            yhqState=0;
            self.archBtn.hidden = YES;
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
        
        [self.archBtn setTitle:quanStr forState:UIControlStateNormal];
        
        self.titleLB.textColor=[UIColor colorWithHexString:model.info_color];
        self.titleLB.text=model.info;
        self.nameLB.text=model.goods_title;
        self.priceLB.text=jointPrice;
        self.originalPriceLB.text=[NSString stringWithFormat:@"¥%@",model.goods_cost_price];
        
        CGFloat priceLBW=[jointPrice kr_getWidthWithTextHeight:22 font:20];
        if(priceLBW>120){
           priceLBW=120;
        }
        CGFloat originalPriceLBW=[originalPrice kr_getWidthWithTextHeight:22 font:14];
        if(originalPriceLBW>100){
           originalPriceLBW=100;
        }
        
        CGFloat yhqW=[quanStr kr_getWidthWithTextHeight:15 font:11];
        if(yhqW>100){
           yhqW=100;
        }
        CGFloat fanliW=[fanliStr kr_getWidthWithTextHeight:15 font:11];
        if(fanliW>120){
           fanliW=120;
        }
        
        self.priceLB.sd_layout
        .leftSpaceToView(self, 187).topSpaceToView(self.typeImgView, 40).heightIs(22).widthIs(priceLBW);
        
        self.originalPriceLB.sd_layout
        .topSpaceToView(self.typeImgView, 40).heightIs(22).rightSpaceToView(self, 12).widthIs(originalPriceLBW);
        
        if([model.goods_price kr_isNotEmpty]){
            //[self.priceLB fn_changeColorWithTextColor:RGB(153, 153, 153) changeText:model.goods_cost_price];
            [self.priceLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:10] changeText:qhjStr];
            [self.priceLB fn_changeFontWithTextFont:[UIFont fontWithName:@"MarkPro-Bold" size:18] changeText:price]; 
        }
        [self.originalPriceLB fn_changeStrikethroughStyleWithTextStrikethroughStyle:@(NSUnderlineStyleSingle) changeText:originalPrice];
        [self.originalPriceLB fn_changeStrikethroughColorWithTextStrikethroughColor:RGB(153, 153, 153) changeText:originalPrice];
        
        self.archBtn.sd_layout
        .leftSpaceToView(self.imgView, 10).topSpaceToView(self.typeImgView, 17).heightIs(15).widthIs(yhqW+5);
        
        CGFloat favourBtnLeftGap=yhqW+5+10;
        
        //判断模式
        if([FNBaseSettingModel settingInstance].app_choujiang_onoff.boolValue){//判断是否是抽奖模式
            self.favourBtn.hidden = YES;
            //[NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].app_fanli_off_str];//抽奖模式文字
        }else{
            // goods_flstyle:0.有返利样式，1.无返利样式
            if (goods_flstyle == 0) {
                if ([model.fcommission kr_isNotEmpty]&&![model.fcommission isEqualToString:@"0"]) {
                    if ([model.is_hide_fl isEqualToString:@"1"]) {
                        self.favourBtn.hidden = YES;
                    }else{
                        self.favourBtn.hidden = NO;
                        [self.favourBtn setTitle:fanliStr forState:UIControlStateNormal];
                        if(yhqState==1){
                           favourBtnLeftGap=185+yhqW+5+5;
                        }else{
                           favourBtnLeftGap=185;
                        }
                        self.favourBtn.sd_layout
                        .leftSpaceToView(self, favourBtnLeftGap).topSpaceToView(self.typeImgView, 17).heightIs(15).widthIs(fanliW+5);
                    }
                }else{
                    self.favourBtn.hidden = YES;
                }
            }else{
                self.favourBtn.hidden = YES;
            }
        }
        if([quanStr kr_isNotEmpty]){
            [self.archBtn.titleLabel fn_changeFontWithTextFont:[UIFont fontWithName:@"MarkPro-Bold" size:10] changeText:quanStr];
        }
        
        if([fanliStr kr_isNotEmpty]){
            [self.favourBtn.titleLabel fn_changeFontWithTextFont:[UIFont fontWithName:@"MarkPro-Bold" size:10] changeText:fanliStr];
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
