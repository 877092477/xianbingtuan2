//
//  FNitemMakeDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/19.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNitemMakeDeCell.h"

@implementation FNitemMakeDeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews{
    self.backgroundColor=RGB(245, 245, 245);
    self.bgView=[[UIView alloc]init];
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.cornerRadius=5;
    [self addSubview:self.bgView];
    
    self.textLB=[UILabel new];
    self.textLB.textColor=RGB(129, 128, 129);
    self.textLB.font=kFONT12;
    self.textLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.textLB];
    
    self.rightTextLB=[UILabel new];
    self.rightTextLB.textColor=RGB(129, 128, 129);
    self.rightTextLB.font=kFONT12;
    self.rightTextLB.textAlignment=NSTextAlignmentRight;
    [self.bgView addSubview:self.rightTextLB];
    
    self.goodsImageView=[UIImageView new];
    self.goodsImageView.cornerRadius=2;
    [self.bgView addSubview:self.goodsImageView];
    
    self.nameLB=[UILabel new];
    self.nameLB.textColor=RGB(129, 128, 129);
    self.nameLB.font=kFONT13;
    self.nameLB.numberOfLines=2;
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.nameLB];
    
    self.priceLB=[UILabel new];
    [self.priceLB sizeToFit];
    self.priceLB.textColor=RGB(244, 62, 121);//FNBlackColor;
    self.priceLB.font=kFONT12;
    self.priceLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.priceLB];
    
    
    self.subsidyLB=[UILabel new];
    [self.subsidyLB sizeToFit];
    self.subsidyLB.textColor=RGB(129, 128, 129);//FNBlackColor;
    self.subsidyLB.font=kFONT12;
    self.subsidyLB.textAlignment=NSTextAlignmentRight;
    [self.bgView addSubview:self.subsidyLB];
    
    self.orderCodeLB=[UILabel new];
    self.orderCodeLB.textColor=RGB(129, 128, 129);
    self.orderCodeLB.font=kFONT12;
    self.orderCodeLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.orderCodeLB];
    
    //self.subsidyLB.backgroundColor=[UIColor grayColor];
    //self.priceLB.backgroundColor=[UIColor lightGrayColor];
    [self inAppointFrames];
    
}

-(void)inAppointFrames{
    CGFloat inter_20=20;
    CGFloat inter_10=10;
    CGFloat inter_15=15;
    CGFloat inter_5=5;
    
    self.bgView.sd_layout
    .bottomEqualToView(self).topSpaceToView(self, inter_10).rightSpaceToView(self, inter_10).leftSpaceToView(self, inter_10);
    
    self.textLB.sd_layout
    .heightIs(15).topSpaceToView(self.bgView, inter_10).leftSpaceToView(self.bgView, inter_10);
    [self.textLB setSingleLineAutoResizeWithMaxWidth:150];
    
    self.rightTextLB.sd_layout
    .heightIs(15).topSpaceToView(self.bgView, inter_10).rightSpaceToView(self.bgView, inter_10);
    [self.rightTextLB setSingleLineAutoResizeWithMaxWidth:150];
    
    self.goodsImageView.sd_layout
    .heightIs(90).widthIs(90).topSpaceToView(self.textLB, inter_10).leftSpaceToView(self.bgView, inter_10);
    
    self.nameLB.sd_layout
    .topSpaceToView(self.textLB, inter_10).rightSpaceToView(self.bgView, inter_10).leftSpaceToView(self.goodsImageView, inter_10).heightIs(35);
    
    self.priceLB.sd_layout
    .heightIs(20).leftSpaceToView(self.goodsImageView, inter_10).bottomEqualToView(self.goodsImageView).widthIs(100);
    
    
    self.subsidyLB.sd_layout
    .heightIs(20).rightSpaceToView(self.bgView, inter_10).bottomEqualToView(self.goodsImageView).widthIs(100);
    
    
    self.orderCodeLB.sd_layout
    .heightIs(15).leftSpaceToView(self.goodsImageView, inter_10).rightSpaceToView(self.bgView, inter_10).topSpaceToView(self.nameLB, inter_10);
    
}

-(void)setModel:(FNitemMakeDeModel *)model{
    _model=model;
    if (model) {
        self.textLB.text=model.shop_title;
        self.rightTextLB.text=model.time;
        self.nameLB.text=model.goods_title;
        if ([model.goods_title kr_isNotEmpty]){
            NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:model.goods_title];
            NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:2];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.goods_title length])];
            [self.nameLB setAttributedText:attributedString];
        }
        
        if ([model.orderId isEqualToString:@""]) {
            self.orderCodeLB.text=[NSString stringWithFormat:@"领取时间:%@",model.time];
        } else {
            self.orderCodeLB.text=[NSString stringWithFormat:@"订单号:%@",model.orderId];
        }
        
        [self.goodsImageView setUrlImg:model.goods_img];
        
        CGFloat inter_10=10;
        
        //  等待确认 :wait_confirm  等待结算: wait_returnstatus  已经结算:returnstatus  失效订单:lose_efficacy
        
        NSString *type=model.type;
        NSString* ptcoupon = @"";
        CGFloat subFontSize=16;
        CGFloat subheight=20;
        if([type isEqualToString:@"wait_confirm"]){
        //等待确认
            self.rightTextLB.hidden=YES;
            self.priceLB.hidden=YES;
            self.subsidyLB.textColor=[UIColor whiteColor];
            self.subsidyLB.backgroundColor=RGB(244, 62, 121);
            NSString *awaitString=@"补充单号";
            self.subsidyLB.textAlignment=NSTextAlignmentCenter;
            self.subsidyLB.font=[UIFont systemFontOfSize:10];
            self.subsidyLB.cornerRadius=2;
            self.subsidyLB.text=awaitString;
            subFontSize=10;
            subheight=20;
            self.subsidyLB.userInteractionEnabled=YES;
            UITapGestureRecognizer *icontap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(confirmAction)];
            [self.subsidyLB addGestureRecognizer:icontap];
            self.subsidyLB.hidden=NO;
            if(![type kr_isNotEmpty]){
                self.subsidyLB.hidden=YES;
            }
        }
       else if([type isEqualToString:@"wait_returnstatus"]){
        //等待结算
            NSString* coupon = @"¥";
            NSString* price = model.goods_price;
            self.priceLB.text =[NSString stringWithFormat:@"%@%@",coupon,model.goods_price];
            [self.priceLB addSingleAttributed:@{NSFontAttributeName:kFONT16} ofRange:[self.priceLB.text rangeOfString:price]];
            self.subsidyLB.textColor=RGB(244, 62, 121);
            ptcoupon = @"平台可补贴:¥";
            NSString* fl_price = model.fl_price;
            self.subsidyLB.text=[NSString stringWithFormat:@"%@%@",ptcoupon,fl_price];
            [self.subsidyLB addSingleAttributed:@{NSFontAttributeName:kFONT16} ofRange:[self.subsidyLB.text rangeOfString:fl_price]];
            self.subsidyLB.hidden=NO;
           if(![type kr_isNotEmpty]){
              self.subsidyLB.hidden=YES;
           }
        }
        else if([type isEqualToString:@"returnstatus"]){
        //已经结算
            NSString* coupon = @"¥";
            NSString* price = model.goods_price;
            self.priceLB.text =[NSString stringWithFormat:@"%@%@",coupon,model.goods_price];
            [self.priceLB addSingleAttributed:@{NSFontAttributeName:kFONT16} ofRange:[self.priceLB.text rangeOfString:price]];
            self.subsidyLB.textColor=RGB(129, 128, 129);
            ptcoupon = @"平台已补贴:¥";
            NSString* fl_price = model.fl_price;
            self.subsidyLB.text=[NSString stringWithFormat:@"%@%@",ptcoupon,fl_price];
            [self.subsidyLB addSingleAttributed:@{NSFontAttributeName:kFONT16} ofRange:[self.subsidyLB.text rangeOfString:fl_price]];
            self.subsidyLB.hidden=NO;
            if(![type kr_isNotEmpty]){
                self.subsidyLB.hidden=YES;
            }
        }
        else if([type isEqualToString:@"lose_efficacy"]){
        //失效订单
            self.subsidyLB.hidden=YES;
            self.priceLB.font=[UIFont systemFontOfSize:12];
            self.priceLB.text=@"订单已失效";
        }else if(![type kr_isNotEmpty]){
            self.subsidyLB.hidden=YES;
        }
        
        CGFloat priceLBW= [self getWidthWithText:self.priceLB.text height:20 font:16];
        
        CGFloat subsidyLBW= [self getWidthWithText:self.subsidyLB.text height:subheight font:subFontSize];
        
        self.priceLB.sd_layout
        .heightIs(20).leftSpaceToView(self.goodsImageView, inter_10).bottomEqualToView(self.goodsImageView).widthIs(priceLBW);
        
        self.subsidyLB.sd_layout
        .heightIs(subheight).rightSpaceToView(self.bgView, inter_10).bottomEqualToView(self.goodsImageView).widthIs(subsidyLBW+5);
        
        [self.subsidyLB updateLayout];
        [self updateLayout];
        
    }
}
-(void)confirmAction{
    if ([self.delegate respondsToSelector:@selector(replenishCodeClick:)]) {
        [self.delegate replenishCodeClick:self.model];
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
