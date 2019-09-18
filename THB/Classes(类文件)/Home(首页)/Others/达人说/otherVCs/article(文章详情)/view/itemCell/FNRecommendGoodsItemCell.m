//
//  FNRecommendGoodsItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//更多推荐
#import "FNRecommendGoodsItemCell.h"

@implementation FNRecommendGoodsItemCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNRecommendGoodsItemCellID";
    FNRecommendGoodsItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    self.goodsImg=[[UIImageView alloc]init];
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.bgImgView];
    [self addSubview:self.goodsImg];
    [self addSubview:self.nameLB]; 
    
    self.ticketTwoImg=[[UIImageView alloc]init];
    [self addSubview:self.ticketTwoImg];
    self.ticketBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.ticketBtn];
    self.prospectBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.prospectBtn];
    
    self.moneyLB=[[UILabel alloc]init];
    [self addSubview:self.moneyLB];
    self.originalPriceLB=[[UILabel alloc]init];
    [self addSubview:self.originalPriceLB];
    self.sellLB=[[UILabel alloc]init];
    [self addSubview:self.sellLB];
    
    self.nameLB.numberOfLines=2;
    self.nameLB.font=kFONT12;
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.moneyLB.font=kFONT15;
    self.moneyLB.textColor=RGB(51, 51, 51);
    self.moneyLB.textAlignment=NSTextAlignmentLeft;
    
    self.originalPriceLB.font=kFONT12;
    self.originalPriceLB.textColor=RGB(153, 153, 153);
    self.originalPriceLB.textAlignment=NSTextAlignmentLeft;
    
    self.sellLB.font=kFONT12;
    self.sellLB.textColor=RGB(153, 153, 153);
    self.sellLB.textAlignment=NSTextAlignmentRight;
    
    self.ticketBtn.titleLabel.font=kFONT10;
    self.prospectBtn.titleLabel.font=kFONT11;
    
    self.bgImgView.backgroundColor=[UIColor whiteColor];
    self.bgImgView.cornerRadius=5;
    //self.goodsImg.cornerRadius=5;
    [self incomposition];
    
}

-(void)incomposition{
    self.bgImgView.sd_layout
    .centerYEqualToView(self).leftSpaceToView(self, 12).rightSpaceToView(self, 12).heightIs(108);
    //.leftSpaceToView(self, 8).topSpaceToView(self, 8).rightSpaceToView(self, 8).bottomSpaceToView(self, 8);
    
    self.goodsImg.sd_layout
    .centerYEqualToView(self).leftSpaceToView(self, 12).widthIs(108).heightIs(108);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.goodsImg, 15).topSpaceToView(self, 13).rightSpaceToView(self, 15).heightIs(30);
    
    self.ticketTwoImg.sd_layout
    .leftSpaceToView(self.goodsImg, 33).topSpaceToView(self.nameLB, 6).heightIs(19).widthIs(30);
    
    self.ticketBtn.sd_layout
    .leftSpaceToView(self.goodsImg, 15).topSpaceToView(self.nameLB, 6).heightIs(19).widthIs(48);
    
    self.prospectBtn.sd_layout
    .leftSpaceToView(self.goodsImg, 73).topSpaceToView(self.nameLB, 6).heightIs(19).widthIs(83);
    
//    self.moneyLB.sd_layout
//    .leftSpaceToView(self.goodsImg, 15).topSpaceToView(self.nameLB, 40).heightIs(15).widthIs(60);
    
    self.moneyLB.sd_layout
    .leftSpaceToView(self.goodsImg, 15).topSpaceToView(self.nameLB, 38).heightIs(20).widthIs(60);
    
    self.originalPriceLB.sd_layout
    .leftSpaceToView(self.goodsImg, 80).topSpaceToView(self.nameLB, 41).heightIs(17).widthIs(60);
    
    self.sellLB.sd_layout
    .rightSpaceToView(self, 25).topSpaceToView(self.nameLB, 41).heightIs(17);
    [self.sellLB setSingleLineAutoResizeWithMaxWidth:80];
    
    
    self.goodsImg.frame=CGRectMake(12, 6, 108, 108);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.goodsImg.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.goodsImg.bounds;
    maskLayer.path = maskPath.CGPath;
    self.goodsImg.layer.mask = maskLayer;
    
}

-(void)setModel:(FNBaseProductModel *)model{
    _model=model; 
    if(model){
        [self.goodsImg setUrlImg:model.goods_img];
        self.nameLB.text=model.goods_title;
        [self.ticketTwoImg setUrlImg:model.goods_quanbj_bjimg];
        [self.ticketBtn sd_setImageWithURL:URL(model.goods_quanfont_bjimg) forState:UIControlStateNormal];
        [self.ticketBtn setTitle:model.yhq_span forState:UIControlStateNormal];
        [self.prospectBtn sd_setBackgroundImageWithURL:URL(model.goods_fanli_bjimg) forState:UIControlStateNormal];
        
        
        NSString *chouJiang=[NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].app_fanli_off_str];//抽奖模式文字
        NSString *fLi=[NSString stringWithFormat:@"%@%@",model.fan_all_str,model.fcommission];
        
        NSString *prospectJoint=fLi;
        
        [self.prospectBtn setTitle:prospectJoint forState:UIControlStateNormal];
        
        self.moneyLB.text=[NSString stringWithFormat:@"¥%@",model.goods_price];
        NSString *originalPrice=[NSString stringWithFormat:@"¥%@",model.goods_cost_price];
        self.originalPriceLB.text=originalPrice;//原价
        self.sellLB.text=[NSString stringWithFormat:@"已售%@",model.goods_sales];
        
        
        CGFloat yhq_spanW= [model.yhq_span kr_getWidthWithTextHeight:19 font:10];
        if(yhq_spanW>100){
            yhq_spanW=100;
        }
        CGFloat prospectBtnW= [prospectJoint kr_getWidthWithTextHeight:19 font:11];
        CGFloat prospectBtnLeft=yhq_spanW+10+18+15+10;
        if(prospectBtnW>100){
            prospectBtnW=100;
        }
        
        CGFloat moneyLBW= [self.moneyLB.text kr_getWidthWithTextHeight:20 font:15];
        if(moneyLBW>80){
            moneyLBW=80;
        }
        CGFloat originalPriceLBW= [self.originalPriceLB.text kr_getWidthWithTextHeight:17 font:12];
        if(originalPriceLBW>80){
            originalPriceLBW=80;
        }
        
        
        self.ticketTwoImg.sd_layout
        .leftSpaceToView(self.goodsImg, 33).topSpaceToView(self.nameLB, 6).heightIs(19).widthIs(yhq_spanW+10);
        
        self.ticketBtn.sd_layout
        .leftSpaceToView(self.goodsImg, 15).topSpaceToView(self.nameLB, 6).heightIs(19).widthIs(yhq_spanW+10+18);
        self.ticketBtn.imageView.sd_layout
        .centerYEqualToView(self.ticketBtn).leftSpaceToView(self.ticketBtn, 0).heightIs(19).widthIs(18);
        self.ticketBtn.titleLabel.sd_layout
        .centerYEqualToView(self.ticketBtn).leftSpaceToView(self.ticketBtn.imageView, 0).heightIs(19).rightSpaceToView(self.ticketBtn, 0);
        
        
        self.moneyLB.sd_layout
        .leftSpaceToView(self.goodsImg, 15).topSpaceToView(self.nameLB, 38).heightIs(20).widthIs(moneyLBW);
        
        self.originalPriceLB.sd_layout
        .leftSpaceToView(self.goodsImg, 15+moneyLBW+5).topSpaceToView(self.nameLB, 41).heightIs(17).widthIs(originalPriceLBW);
        
        [self.originalPriceLB fn_changeStrikethroughColorWithTextStrikethroughColor:RGB(153, 153, 153) changeText:originalPrice];
        [self.originalPriceLB fn_changeStrikethroughStyleWithTextStrikethroughStyle:@(NSUnderlineStyleSingle) changeText:originalPrice];
        
        self.ticketBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.ticketBtn setTitleColor:[UIColor colorWithHexString:model.goodsyhqstr_color] forState:UIControlStateNormal];
        [self.prospectBtn setTitleColor:[UIColor colorWithHexString:model.goodsfcommissionstr_color] forState:UIControlStateNormal];
        
        self.moneyLB.textColor=RGB(219, 3, 46);
        
        //判断优惠券,没有就隐藏
        if ([model.yhq_span kr_isNotEmpty]&&![model.yhq_price isEqualToString:@"0"]) {
            self.ticketBtn.hidden = NO;
        }else{
            //显示到手价标题
            //_qhPriceTitleLabel.text=[FNBaseSettingModel settingInstance].app_daoshoujia_name;
            self.ticketBtn.hidden = YES;
            prospectBtnLeft=15;
        }
         
        //返利样式
        NSInteger goods_flstyle=[[FNBaseSettingModel settingInstance].goods_flstyle integerValue ];
        if([FNBaseSettingModel settingInstance].app_choujiang_onoff.boolValue){//判断是否是抽奖模式
           self.prospectBtn.hidden = NO;
        }else{
            // goods_flstyle:0.有返利样式，1.无返利样式
            if (goods_flstyle == 0) {
                if ([model.fcommission kr_isNotEmpty]&&![model.fcommission isEqualToString:@"0"]) {
                    self.prospectBtn.hidden = YES;
                }else{
                    self.prospectBtn.hidden = NO;
                }
            }else{
                self.prospectBtn.hidden = YES;
                
            }
            
        }
        
        self.prospectBtn.sd_layout
        .leftSpaceToView(self.goodsImg, prospectBtnLeft).topSpaceToView(self.nameLB, 6).heightIs(19).widthIs(prospectBtnW+10);
    }
}
@end
