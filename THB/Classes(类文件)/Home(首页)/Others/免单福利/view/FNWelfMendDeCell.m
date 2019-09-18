//
//  FNWelfMendDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//福利补贴
#import "FNWelfMendDeCell.h"

@implementation FNWelfMendDeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews
{
    
    self.backgroundColor=RGB(245, 245, 245);
    
    self.bgView=[[UIView alloc]init];
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.cornerRadius=15/2;
    [self addSubview:self.bgView];
    
    self.textLB=[UILabel new];
    self.textLB.textColor=FNBlackColor;
    self.textLB.font=kFONT14;
    self.textLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.textLB];
    
    self.lineView=[[UIView alloc]init];
    self.lineView.backgroundColor=RGB(245, 245, 245);
    [self.bgView addSubview:self.lineView];
    
    self.goodsImageView=[UIImageView new];
    [self.bgView addSubview:self.goodsImageView];
    
    self.nameLB=[UILabel new];
    self.nameLB.textColor=FNBlackColor;
    self.nameLB.font=kFONT13;
    self.nameLB.numberOfLines=2;
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.nameLB];

    
    self.mendImage=[UIImageView new];
    [self.bgView addSubview:self.mendImage];
    
    self.mendLB=[UILabel new];
    self.mendLB.textColor=FNWhiteColor;
    self.mendLB.font=[UIFont systemFontOfSize:9];
    self.mendLB.textAlignment=NSTextAlignmentCenter;
    [self.mendImage addSubview:self.mendLB];
    
    self.mendPriceLB=[UILabel new];
    self.mendPriceLB.textColor=FNWhiteColor;
    self.mendPriceLB.font=[UIFont systemFontOfSize:9];
    self.mendPriceLB.textAlignment=NSTextAlignmentCenter;
    [self.mendImage addSubview:self.mendPriceLB];

    self.priceLB=[UILabel new];
    [self.priceLB sizeToFit];
    self.priceLB.textColor=RGB(244, 62, 121);//FNBlackColor;
    self.priceLB.font=kFONT10;
    self.priceLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.priceLB]; 
    
    self.rawLB=[UILabel new];
    [self.rawLB sizeToFit];
    self.rawLB.textColor=RGB(129, 128, 129);
    self.rawLB.font=kFONT10;
    self.rawLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.rawLB];
    
    self.lineBase=[[UIView alloc]init];
    self.lineBase.backgroundColor=RGB(129, 128, 129);
    [self.bgView addSubview:self.lineBase];
    
    
    self.sellImageView=[UIImageView new];
    self.sellImageView.backgroundColor= RGB(253, 205, 220);
    self.sellImageView.cornerRadius=5;
    self.sellImageView.borderWidth=0.5;
    self.sellImageView.borderColor = RGB(244, 62, 121);
    self.sellImageView.clipsToBounds = YES;
    [self.bgView addSubview:self.sellImageView];
    
    self.planLB=[[UILabel alloc]init];
    self.planLB.cornerRadius=5;
    self.planLB.backgroundColor=RGB(244, 62, 121);
    [self.sellImageView addSubview:self.planLB];
    
    self.leftSellLB=[UILabel new];
    [self.leftSellLB sizeToFit];
    //self.leftSellLB.cornerRadius=5;
    self.leftSellLB.textColor=[UIColor whiteColor];
    //self.leftSellLB.backgroundColor=RGB(244, 62, 121);
    self.leftSellLB.font=[UIFont systemFontOfSize:7];
    self.leftSellLB.textAlignment=NSTextAlignmentCenter;
    [self.sellImageView addSubview:self.leftSellLB];
    
    self.rightSellLB=[UILabel new];
    [self.rightSellLB sizeToFit];
    self.rightSellLB.textColor= RGB(244, 62, 121);
    self.rightSellLB.font=[UIFont systemFontOfSize:7];
    self.rightSellLB.textAlignment=NSTextAlignmentRight;
    [self.sellImageView addSubview:self.rightSellLB];
    
    [self incomposition];
    
    self.backgroundColor=RGB(245, 245, 245);
   
}
-(void)incomposition{
    CGFloat inter_20=20;
    CGFloat inter_10=10;
    CGFloat inter_5=5;
    self.bgView.sd_layout
    .bottomEqualToView(self).topSpaceToView(self, 0).rightSpaceToView(self, inter_10).leftSpaceToView(self, inter_10);
    
    self.textLB.sd_layout
    .heightIs(15).topSpaceToView(self.bgView, inter_5).rightSpaceToView(self.bgView, inter_10).leftSpaceToView(self.bgView, inter_10);
    
    self.lineView.sd_layout
    .heightIs(1).topSpaceToView(self.textLB, inter_10).rightSpaceToView(self.bgView, inter_10).leftSpaceToView(self.bgView, inter_10);
    
    self.goodsImageView.sd_layout
    .heightIs(115).widthIs(115).topSpaceToView(self.lineView, inter_10).leftSpaceToView(self.bgView, inter_10);
    
    
    self.nameLB.sd_layout
    .topSpaceToView(self.lineView, inter_10).rightSpaceToView(self.bgView, inter_20).leftSpaceToView(self.goodsImageView, inter_10).heightIs(35);
    
    self.priceLB.sd_layout
    .heightIs(20).widthIs(80).leftSpaceToView(self.goodsImageView, inter_10).bottomEqualToView(self.goodsImageView);
    
    self.rawLB.sd_layout
    .heightIs(15).widthIs(80).leftSpaceToView(self.priceLB, inter_20).bottomEqualToView(self.goodsImageView);
    
    self.mendImage.sd_layout
    .heightIs(35).rightSpaceToView(self.bgView, inter_20).bottomEqualToView(self.goodsImageView).widthIs(50);
    self.mendLB.sd_layout
    .heightIs(17).rightSpaceToView(self.mendImage, 0).topEqualToView(self.mendImage).leftSpaceToView(self.mendImage, 0);
    self.mendPriceLB.sd_layout
    .heightIs(17).rightSpaceToView(self.mendImage, 0).bottomEqualToView(self.mendImage).leftSpaceToView(self.mendImage, 0);
    
    self.lineBase.sd_layout
    .heightIs(1).widthIs(1).leftSpaceToView(self.priceLB, 18).centerYEqualToView(self.priceLB);
    
    self.sellImageView.sd_layout
    .heightIs(10).widthIs(95).leftSpaceToView(self.goodsImageView, inter_10).bottomSpaceToView(self.priceLB, 30);
    
    self.leftSellLB.sd_layout
    .leftSpaceToView(self.sellImageView, 0).heightIs(10).centerYEqualToView(self.sellImageView);
    [self.leftSellLB setSingleLineAutoResizeWithMaxWidth:70];
    
    self.rightSellLB.sd_layout
    .heightIs(10).rightSpaceToView(self.sellImageView, inter_5).centerYEqualToView(self.sellImageView);
    
    [self.rightSellLB setSingleLineAutoResizeWithMaxWidth:40];
    
    
}
-(void)setModel:(FNwelfDeListItemModel *)model{
    _model=model;
    if(model){
        CGFloat inter_20=20;
        CGFloat inter_10=10;
        self.textLB.text=model.shop_title;//@"pretty girl公主";
        self.nameLB.text=model.goods_title;//@"2018秋冬新款韩版假两件毛呢外套女中长款学生加厚流行毛呢大衣";
        
        NSString *typeString=@"¥";
        self.priceLB.text=[NSString stringWithFormat:@"%@%@",typeString,model.goods_price];//@"¥258";
        self.rawLB.text=[NSString stringWithFormat:@"%@%@",typeString,model.goods_cost_price];//;//@"¥358";
        [self.goodsImageView setUrlImg:model.goods_img];
        
        [self.mendImage setUrlImg:model.fl_bj_img];
        self.mendLB.text=model.pt_str;//@"平台补贴";
        self.mendPriceLB.text=[NSString stringWithFormat:@"%@%@",typeString,model.fl_price];//@"¥100";
        
        CGFloat priceW=  [self getWidthWithText:self.priceLB.text height:20 font:16];
        self.priceLB.sd_layout
        .heightIs(20).widthIs(priceW).leftSpaceToView(self.goodsImageView, inter_10).bottomEqualToView(self.goodsImageView);
        
        CGFloat rawLBW=  [self getWidthWithText:self.rawLB.text height:15 font:10];
        self.rawLB.sd_layout
        .heightIs(15).widthIs(rawLBW).leftSpaceToView(self.priceLB, inter_20).bottomEqualToView(self.goodsImageView);
        
        self.lineBase.sd_layout
        .heightIs(1).widthIs(rawLBW+4).leftSpaceToView(self.priceLB, 18).centerYEqualToView(self.rawLB);
        
        NSString* coupon = @"¥";
        NSString* price = model.goods_price;
        self.priceLB.text =[NSString stringWithFormat:@"%@%@",coupon,model.goods_price];
        [self.priceLB addSingleAttributed:@{NSFontAttributeName:kFONT16} ofRange:[self.priceLB.text rangeOfString:price]];
        
        self.sellImageView.image=IMAGE(@"Fn_flJB_img");
        NSString *bf=@"%";
        self.rightSellLB.text=[NSString stringWithFormat:@"%@%@",model.jindu,bf];//@"48%";
        if([model.jindu integerValue]==100){
            self.rightSellLB.textColor=[UIColor whiteColor];
        }
        NSString *joint_sales=[NSString stringWithFormat:@"已抢%@件",model.goods_sales];
        CGFloat salesW=  [self getWidthWithText:joint_sales height:10 font:8];
        self.leftSellLB.sd_layout
        .leftSpaceToView(self.sellImageView, 5).heightIs(10).centerYEqualToView(self.sellImageView);//.widthIs(salesW+5);
        [self.leftSellLB setSingleLineAutoResizeWithMaxWidth:60];
        self.leftSellLB.text=joint_sales;//@"已抢365件";
        
        CGFloat finish=[model.jindu floatValue]/100;
        CGFloat planW=95*finish;
       
        self.planLB.sd_layout
        .leftSpaceToView(self.sellImageView, 0).heightIs(10).centerYEqualToView(self.sellImageView).widthIs(ceilf(planW));

    }
}

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
@end
