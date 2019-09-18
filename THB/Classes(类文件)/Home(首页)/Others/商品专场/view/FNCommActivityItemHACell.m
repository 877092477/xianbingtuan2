//
//  FNCommActivityItemHACell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCommActivityItemHACell.h"

@implementation FNCommActivityItemHACell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNCommActivityItemHACellID";
    FNCommActivityItemHACell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    self.bgImgView.cornerRadius=5;
    self.bgImgView.clipsToBounds = YES;
    
    self.topImgView=[[UIImageView alloc]init];
    [self.bgImgView addSubview:self.topImgView];
    
    self.nameLB=[[UILabel alloc]init];
    self.priceLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    [self addSubview:self.priceLB];
    
    self.ticketTwoImg=[[UIImageView alloc]init];
    [self addSubview:self.ticketTwoImg];
    self.ticketBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.ticketBtn];
    self.prospectBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.prospectBtn];
    
    self.ticketBtn.titleLabel.font=kFONT11;
    self.prospectBtn.titleLabel.font=kFONT11;
    
    self.nameLB.font=[UIFont systemFontOfSize:12];
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.priceLB.font=[UIFont systemFontOfSize:9];//[UIFont fontWithName:@"Copperplate-Light" size:9];//[UIFont systemFontOfSize:12];
    self.priceLB.textColor=RGB(245, 66, 110);
    self.priceLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0);
    
    self.topImgView.sd_layout
    .leftSpaceToView(self.bgImgView, 0).topSpaceToView(self.bgImgView, 0).heightIs(115).widthIs(115);
    
    self.topImgView.frame=CGRectMake(0, 0, 115, 115);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.topImgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.topImgView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.topImgView.layer.mask = maskLayer;
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 5).heightIs(18).rightSpaceToView(self, 5).topSpaceToView(self, 122);
    
    self.priceLB.sd_layout
    .leftSpaceToView(self, 5).bottomSpaceToView(self, 8).heightIs(20).rightSpaceToView(self, 5);
    
    self.ticketTwoImg.sd_layout
    .leftSpaceToView(self, 23).topSpaceToView(self.nameLB, 10).heightIs(14).widthIs(38);
    
    self.ticketBtn.sd_layout
    .leftSpaceToView(self, 5).topSpaceToView(self.nameLB, 10).heightIs(14).widthIs(55);
    
    self.prospectBtn.sd_layout
    .leftSpaceToView(self, 67).topSpaceToView(self.nameLB, 10).heightIs(14).widthIs(33); 
    
    
}

-(void)setModel:(FNBaseProductModel *)model{
    _model=model;
    if(model){
        if([model.shadow_color kr_isNotEmpty]){
           self.bgImgView.borderColor = [UIColor colorWithHexString:model.shadow_color];
        }
        [self.topImgView setUrlImg:model.goods_img];
        
        [self.ticketTwoImg setUrlImg:model.goods_quanbj_bjimg];
        [self.ticketBtn sd_setImageWithURL:URL(model.goods_quanfont_bjimg) forState:UIControlStateNormal];
       
        [self.prospectBtn sd_setBackgroundImageWithURL:URL(model.goods_fanli_bjimg) forState:UIControlStateNormal];
        
        //[self.ticketBtn setTitle:model.yhq_span forState:UIControlStateNormal];
        [self.ticketBtn setTitleColor:[UIColor colorWithHexString:model.goodsyhqstr_color] forState:UIControlStateNormal];
        [self.prospectBtn setTitleColor:[UIColor colorWithHexString:model.goodsfcommissionstr_color] forState:UIControlStateNormal];
        
        //返利样式
        NSInteger goods_flstyle=[[FNBaseSettingModel settingInstance].goods_flstyle integerValue];
        if (goods_flstyle==0 || goods_flstyle==1) {
            
        }else{
            
        } 
        
        if([model.fxz kr_isNotEmpty]){
            if ([model.is_hide_sharefl isEqualToString:@"1"]) {
            }else{
            }
        }else{
            
        }
        NSString *qhjStr=@"";
        NSInteger yhqState=0;
        //判断优惠券,没有就隐藏
        if ([model.yhq_span kr_isNotEmpty]&&![model.yhq_price isEqualToString:@"0"]) {
            yhqState=1;
            self.ticketBtn.hidden = NO;
            self.ticketTwoImg.hidden = NO;
            qhjStr=[NSString stringWithFormat:@"%@¥",[FNBaseSettingModel settingInstance].app_quanhoujia_name];
        }else{
            yhqState=0;
            self.ticketBtn.hidden = YES;
            self.ticketTwoImg.hidden = YES;
            qhjStr=[NSString stringWithFormat:@"%@¥",[FNBaseSettingModel settingInstance].app_daoshoujia_name];
            //显示到手价标题
        }
        CGFloat goodsPriceFloat=[model.goods_price floatValue];
        
        NSString *price=[NSString stringWithFormat:@"%.2f",goodsPriceFloat];
        
        NSString *jointPrice=[NSString stringWithFormat:@"%@%@",qhjStr,price];
        
        CGFloat fcommissionFloat=[model.fcommission floatValue];
        
        NSString *fanliStr=[NSString stringWithFormat:@"%@%.2f",model.fan_all_str,fcommissionFloat];
        
        NSString *quanStr=[NSString stringWithFormat:@"%@",model.yhq_span];
        
        [self.ticketBtn setTitle:quanStr forState:UIControlStateNormal];
        
        self.nameLB.text=model.goods_title;
        
        self.priceLB.text=jointPrice;
        
        CGFloat yhqW=[quanStr kr_getWidthWithTextHeight:14 font:11];
        if(yhqW>45){
            yhqW=45;
        }
        CGFloat fanliW=[fanliStr kr_getWidthWithTextHeight:14 font:11];
        if(fanliW>45){
            fanliW=45;
        }
        
        if([model.goods_price kr_isNotEmpty]){
            //[self.priceLB fn_changeColorWithTextColor:RGB(153, 153, 153) changeText:model.goods_cost_price];
            [self.priceLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:9] changeText:qhjStr];
            [self.priceLB fn_changeFontWithTextFont:[UIFont fontWithName:@"MarkPro-Bold" size:14] changeText:price];
            
        }
        
        self.ticketTwoImg.sd_layout
        .leftSpaceToView(self, 22).topSpaceToView(self.nameLB, 10).heightIs(14).widthIs(yhqW+10);
        
        self.ticketBtn.sd_layout
        .leftSpaceToView(self, 5).topSpaceToView(self.nameLB, 10).heightIs(14).widthIs(17+yhqW+10);
        
        self.ticketBtn.imageView.sd_layout
        .leftSpaceToView(self.ticketBtn, 0).topSpaceToView(self.ticketBtn, 0).heightIs(14).widthIs(17);
        
        self.ticketBtn.titleLabel.sd_layout
        .leftSpaceToView(self.ticketBtn, 22).topSpaceToView(self.ticketBtn, 0).heightIs(14).widthIs(yhqW);
        
        CGFloat favourBtnLeftGap=5+17+yhqW+20;
        
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
                            favourBtnLeftGap=5+17+yhqW+10+5;
                        }else{
                            favourBtnLeftGap=5;
                        }
                        self.prospectBtn.sd_layout
                        .leftSpaceToView(self, favourBtnLeftGap).topSpaceToView(self.nameLB, 10).heightIs(14).widthIs(fanliW+5);
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
@end
