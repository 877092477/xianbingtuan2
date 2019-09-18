//
//  FNCommRecommendPView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCommRecommendPView.h"

@implementation FNCommRecommendPView

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //self.layer.cornerRadius = 10/2;
        //self.clipsToBounds = YES;
        [self initializedSubviews];
    } return self;
}
// 准备弹出(初始化弹层位置)
- (void)willPopupContainer:(DSHPopupContainer *)container; {
    CGRect frame = self.frame;
    frame.size = CGSizeMake(305, 430);
    frame.origin.x = (container.frame.size.width - frame.size.width) * .5;
    frame.origin.y = (container.frame.size.height - frame.size.height) * .5;
    self.frame = frame;
}

// 已弹出(做弹出动画)
- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(1.f, 1.f);
    }];
}

// 将要移除(做移除动画)
- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    CGRect frame = self.frame;
    frame.origin.y = container.frame.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.f;
    }];
}
- (void)initializedSubviews{
    self.bgView=[[UIView alloc]init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.cornerRadius=5;
    [self addSubview:self.bgView];
    
    self.cancelBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.cancelBtn];
    [self.cancelBtn setImage:IMAGE(@"video_card_alert_close") forState:UIControlStateNormal];
    
    self.topImgView=[[UIImageView alloc]init];
    self.topImgView.backgroundColor=  RGB(240, 240, 240);
    self.topImgView.cornerRadius=5;
    [self.bgView addSubview:self.topImgView];
    
    self.typeImgView=[[UIImageView alloc]init];
    [self.bgView addSubview:self.typeImgView];
    
    self.nameLB=[[UILabel alloc]init];
    self.priceLB=[[UILabel alloc]init];
    self.originalPriceLB=[[UILabel alloc]init];
    self.salesLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.nameLB];
    [self.bgView addSubview:self.priceLB];
    [self.bgView addSubview:self.originalPriceLB];
    [self.bgView addSubview:self.salesLB];
    
    self.ticketBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.ticketBtn];
    self.prospectBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.prospectBtn];
    self.lookBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.lookBtn];
    
    self.lookBtn.hidden=YES;
    self.ticketBtn.titleLabel.font=kFONT11;
    self.prospectBtn.titleLabel.font=kFONT11;
    self.lookBtn.titleLabel.font=kFONT15;
    self.lookBtn.backgroundColor=RGB(255, 68, 67);
    [self.lookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]; 
    [self.lookBtn setTitle:@"去看看" forState:UIControlStateNormal];
    self.lookBtn.cornerRadius=43/2;
    
    self.nameLB.font=[UIFont systemFontOfSize:12];
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.priceLB.font=[UIFont systemFontOfSize:12];
    self.priceLB.textColor=RGB(254, 67, 62);
    self.priceLB.textAlignment=NSTextAlignmentLeft;
    
    self.originalPriceLB.font=[UIFont systemFontOfSize:12];
    self.originalPriceLB.textColor=RGB(153, 153, 153);
    self.originalPriceLB.textAlignment=NSTextAlignmentLeft;
    
    self.salesLB.font=[UIFont systemFontOfSize:12];
    self.salesLB.textColor=RGB(153, 153, 153);
    self.salesLB.textAlignment=NSTextAlignmentRight;
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 25).topSpaceToView(self,25).bottomSpaceToView(self, 25).rightSpaceToView(self, 25);
    
    self.cancelBtn.sd_layout
    .topSpaceToView(self,0).rightSpaceToView(self, 0).widthIs(25).heightIs(25);
    
    self.topImgView.sd_layout
    .topSpaceToView(self.bgView, 10).heightIs(225).widthIs(225).centerXEqualToView(self.bgView);
    
    self.typeImgView.sd_layout
    .leftSpaceToView(self.bgView, 15).topSpaceToView(self.topImgView, 10).widthIs(14).heightIs(14);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.typeImgView, 5).heightIs(18).rightSpaceToView(self.bgView, 15).centerYEqualToView(self.typeImgView);
    
    self.priceLB.sd_layout
    .leftSpaceToView(self.bgView, 15).topSpaceToView(self.typeImgView, 36).heightIs(19).widthIs(100);
    
    self.originalPriceLB.sd_layout
    .topSpaceToView(self.typeImgView, 36).heightIs(19).leftSpaceToView(self.bgView, 100).widthIs(35);
    
    self.ticketBtn.sd_layout
    .leftSpaceToView(self.bgView, 15).topSpaceToView(self.typeImgView, 12).heightIs(15).widthIs(30);
    
    self.prospectBtn.sd_layout
    .leftSpaceToView(self.bgView, 65).topSpaceToView(self.typeImgView, 12).heightIs(15).widthIs(37);
    
    self.salesLB.sd_layout
    .rightSpaceToView(self.bgView, 15).topSpaceToView(self.typeImgView, 36).heightIs(19).widthIs(60);
    
    self.lookBtn.sd_layout
    .bottomSpaceToView(self.bgView, 15).heightIs(43).widthIs(157).centerXEqualToView(self.bgView);
    
}

-(void)setGoodModel:(FNBaseProductModel *)goodModel{
    _goodModel=goodModel;
    if(goodModel){
        self.lookBtn.hidden=NO;
        [self.lookBtn addTarget:self action:@selector(lookBtnClick)];
        
        [self.topImgView setUrlImg:goodModel.goods_img];
        [self.typeImgView setUrlImg:goodModel.shop_img];
        
        self.nameLB.text=goodModel.goods_title;
        
        [self.ticketBtn sd_setBackgroundImageWithURL:URL(goodModel.goods_quanbj_bjimg) forState:UIControlStateNormal];
        
        [self.prospectBtn sd_setBackgroundImageWithURL:URL(goodModel.goods_fanli_bjimg) forState:UIControlStateNormal];
        
        
        //[self.ticketBtn setTitle:goodModel.yhq_span forState:UIControlStateNormal];
        
        [self.ticketBtn setTitleColor:[UIColor colorWithHexString:goodModel.goodsyhqstr_color] forState:UIControlStateNormal];
        
        [self.prospectBtn setTitleColor:[UIColor colorWithHexString:goodModel.goodsfcommissionstr_color] forState:UIControlStateNormal];
        
        //XYLog(@"yhq_price=%@    yhq_span=%@",goodModel.yhq_price,goodModel.yhq_span);
        
        //[self.ticketBtn setTitle:goodModel.yhq_span forState:UIControlStateNormal];
        
        //[self.prospectBtn setTitle:goodModel.fcommission forState:UIControlStateNormal];
        
        //返利样式
        NSInteger goods_flstyle=[[FNBaseSettingModel settingInstance].goods_flstyle integerValue];
        if (goods_flstyle==0 || goods_flstyle==1) {
            self.salesLB.text=[NSString stringWithFormat:@"热销 %@",goodModel.goods_sales];
        }else{
            self.salesLB.text=[NSString stringWithFormat:@"%@人已买",goodModel.goods_sales];
        }
        
        NSString *qhjStr=@"";
        NSInteger yhqState=0;
        //判断优惠券,没有就隐藏
        if ([goodModel.yhq_span kr_isNotEmpty]&&![goodModel.yhq_price isEqualToString:@"0"]) {
            yhqState=1;
            self.ticketBtn.hidden = NO;
            qhjStr=[FNBaseSettingModel settingInstance].app_quanhoujia_name;
        }else{
            yhqState=0;
            self.ticketBtn.hidden = YES;
            qhjStr=[FNBaseSettingModel settingInstance].app_daoshoujia_name;
            //显示到手价标题
        }
        NSString *jointPrice=[NSString stringWithFormat:@"%@¥%@",qhjStr,goodModel.goods_price];
        
        NSString *originalPrice=[NSString stringWithFormat:@"¥%@",goodModel.goods_cost_price];
        
        CGFloat fcommissionFloat=[goodModel.fcommission floatValue];
        
        NSString *fanliStr=[NSString stringWithFormat:@"%@%.2f",goodModel.fan_all_str,fcommissionFloat];
        
        NSString *quanStr=[NSString stringWithFormat:@"券%@",goodModel.yhq_span];
        
        [self.ticketBtn setTitle:quanStr forState:UIControlStateNormal];
        
        
        self.priceLB.text=jointPrice;
        self.originalPriceLB.text=[NSString stringWithFormat:@"¥%@",goodModel.goods_cost_price];
        
        CGFloat priceLBW=[jointPrice kr_getWidthWithTextHeight:20 font:18];
        if(priceLBW>120){
            priceLBW=120;
        }
        CGFloat originalPriceLBW=[originalPrice kr_getWidthWithTextHeight:20 font:12];
        if(originalPriceLBW>80){
            originalPriceLBW=80;
        }
        
        CGFloat yhqW=[quanStr kr_getWidthWithTextHeight:15 font:11];
        if(yhqW>100){
            yhqW=100;
        }
        CGFloat fanliW=[fanliStr kr_getWidthWithTextHeight:15 font:11];
        if(fanliW>120){
           fanliW=120;
        }
        
        self.ticketBtn.sd_layout
        .leftSpaceToView(self.bgView, 15).topSpaceToView(self.typeImgView, 12).heightIs(15).widthIs(yhqW+5);
        
        CGFloat originalPriceLeftGap=15+priceLBW+5;
        
        self.priceLB.sd_layout
        .leftSpaceToView(self.bgView, 15).topSpaceToView(self.typeImgView, 36).heightIs(19).widthIs(priceLBW);
        
        self.originalPriceLB.sd_layout
        .topSpaceToView(self.typeImgView, 36).heightIs(19).leftSpaceToView(self.bgView, originalPriceLeftGap).widthIs(originalPriceLBW);
        
        if([goodModel.goods_price kr_isNotEmpty]){
            //[self.priceLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:18] changeText:goodModel.goods_price];
            [self.priceLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:12] changeText:qhjStr];
            [self.priceLB fn_changeFontWithTextFont:[UIFont fontWithName:@"MarkPro-Bold" size:18] changeText:goodModel.goods_price];
        }
        [self.originalPriceLB fn_changeStrikethroughStyleWithTextStrikethroughStyle:@(NSUnderlineStyleSingle) changeText:originalPrice];
        [self.originalPriceLB fn_changeStrikethroughColorWithTextStrikethroughColor:RGB(153, 153, 153) changeText:originalPrice];
        
         CGFloat prospectBtnLeftGap=15+yhqW+10;
        //判断模式
        if([FNBaseSettingModel settingInstance].app_choujiang_onoff.boolValue){//判断是否是抽奖模式
            self.prospectBtn.hidden = YES;
            //[NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].app_fanli_off_str];//抽奖模式文字
        }else{
            // goods_flstyle:0.有返利样式，1.无返利样式
            if (goods_flstyle == 0) {
                if ([goodModel.fcommission kr_isNotEmpty]&&![goodModel.fcommission isEqualToString:@"0"]) {
                    if ([goodModel.is_hide_fl isEqualToString:@"1"]) {
                        self.prospectBtn.hidden = YES;
                    }else{
                        self.prospectBtn.hidden = NO;
                        [self.prospectBtn setTitle:fanliStr forState:UIControlStateNormal];
                        if(yhqState==1){
                            prospectBtnLeftGap=15+yhqW+5+10;
                        }else{
                            prospectBtnLeftGap=15;
                        }
                        self.prospectBtn.sd_layout
                        .leftSpaceToView(self.bgView, prospectBtnLeftGap).topSpaceToView(self.typeImgView, 12).heightIs(15).widthIs(fanliW+5);
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
-(void)lookBtnClick{
    if (self.showCheckGoods) {
        self.showCheckGoods(self.goodModel);
    }
}
@end
