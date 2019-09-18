//
//  FNsomeItemTeCell.m
//  THB
//
//  Created by 李显 on 2019/1/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNsomeItemTeCell.h"

@implementation FNsomeItemTeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.backgroundColor=RGB(243, 243, 243);
    
    self.bgView=[[UIView alloc]init];
    self.bgView.cornerRadius=5/2;
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.bgView];
    
    self.choiceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.choiceBtn setImage:IMAGE(@"FK_blue_Norxz_img") forState:UIControlStateNormal];
    [self.choiceBtn setImage:IMAGE(@"FK_blue_xz_img") forState:UIControlStateSelected];
    [self.choiceBtn addTarget:self action:@selector(choiceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.choiceBtn];
    
    self.goodsImg=[UIImageView new];
    [self.bgView addSubview:self.goodsImg];
    
    self.nameLB=[UILabel new];
    self.nameLB.font=kFONT14;
    self.nameLB.numberOfLines=2;
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.nameLB];
    
    self.sumLB=[UILabel new];
    self.sumLB.font=kFONT12;
    self.sumLB.textColor=RGB(185, 185, 185);
    self.sumLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.sumLB];
    
    self.soldLB=[UILabel new];
    self.soldLB.font=kFONT11;
    self.sumLB.textColor=RGB(185, 185, 185);
    self.soldLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.soldLB];
    
    self.estimateLB=[UILabel new];
    self.estimateLB.font=[UIFont systemFontOfSize:9];
    self.estimateLB.textAlignment=NSTextAlignmentCenter;
    self.estimateLB.textColor=RGB(239, 98, 112);
    self.estimateLB.backgroundColor=RGB(247, 226, 228);
    [self.bgView addSubview:self.estimateLB];
    
    self.ticketImg=[UIImageView new];
    [self.bgView addSubview:self.ticketImg];
    
    self.ticketLB=[UILabel new];
    self.ticketLB.font=[UIFont systemFontOfSize:9];
    self.ticketLB.textAlignment=NSTextAlignmentLeft;
    [self.ticketImg addSubview:self.ticketLB];
    
   
    
    [self incomposition];
}
-(void)incomposition{
    
    CGFloat inter_10=10;
    
    self.bgView.sd_layout
    .leftSpaceToView(self,inter_10).rightSpaceToView(self,inter_10).topSpaceToView(self, 0).bottomSpaceToView(self, inter_10);
    
   
    
    self.choiceBtn.sd_layout
    .centerYEqualToView(self.bgView).leftSpaceToView(self.bgView, 0).widthIs(30).heightIs(30);
    
    self.choiceBtn.imageView.sd_layout
    .centerYEqualToView(self.choiceBtn).centerXEqualToView(self.choiceBtn).widthIs(12).heightIs(12);
    
    self.goodsImg.sd_layout
    .centerYEqualToView(self.bgView).leftSpaceToView(self.choiceBtn,0).widthIs(95).heightIs(95);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.goodsImg, inter_10).topEqualToView(self.goodsImg).rightSpaceToView(self.bgView, inter_10).heightIs(35);
    
    self.sumLB.sd_layout
    .leftSpaceToView(self.goodsImg, inter_10).topSpaceToView(self.nameLB, 0).rightSpaceToView(self.bgView, inter_10).heightIs(20);
    
    self.soldLB.sd_layout
    .leftSpaceToView(self.goodsImg, inter_10).topSpaceToView(self.sumLB, 0).rightSpaceToView(self.bgView, inter_10).heightIs(20);
    
    self.estimateLB.sd_layout
    .rightSpaceToView(self.bgView, inter_10).bottomSpaceToView(self.bgView, inter_10).widthIs(85).heightIs(15);
    
    self.ticketImg.sd_layout
    .leftSpaceToView(self.goodsImg, inter_10).bottomSpaceToView(self.bgView, inter_10).widthIs(45).heightIs(15);
    
    self.ticketLB.sd_layout
    .leftSpaceToView(self.ticketImg,0).rightSpaceToView(self.ticketImg,0).topSpaceToView(self.ticketImg, 0).bottomSpaceToView(self.ticketImg, 0);
    
}

-(void)setModel:(FNBaseProductModel *)model{
    _model=model;
    if (model) {
        
        [self.goodsImg setUrlImg:model.goods_img];
        self.nameLB.text=model.goods_title;
        [self.nameLB HttpLabelLeftImage:model.shop_img label:self.nameLB imageX:0 imageY:-1.5 imageH:15 atIndex:0];
        NSString* coupon = @"";
        if([model.goods_price kr_isNotEmpty]){
            coupon = [NSString stringWithFormat:@"¥%@%@",model.goods_price,@"  "];
        }
        NSString* importString=@"";
        if([model.pdd integerValue]==1){
            importString=@"拼多多价";
        }else if([model.jd integerValue]==1){
            importString=@"京东价";
        }else if([model.shop_id integerValue]==1){
            importString=@"淘宝价";
        }else if([model.shop_id integerValue]==2){
            importString=@"天猫价";
        }
        NSString* price = [NSString stringWithFormat:@"¥%@%@",importString,model.goods_cost_price];
        self.sumLB.text =[NSString stringWithFormat:@"%@%@",coupon,price];
        if ([coupon kr_isNotEmpty]) {
            [self.sumLB addSingleAttributed:@{NSForegroundColorAttributeName:RGB(239, 98, 112)} ofRange:[self.sumLB.text rangeOfString:coupon]];
        }
        
        self.soldLB.text= [NSString stringWithFormat:@"已售%@",model.goods_sales];;
        
        self.estimateLB.text=model.fcommission_str;
        
        [self.ticketImg setNoPlaceholderUrlImg:model.goodsbank_quan_img];
        
        NSString *ticketString=[NSString stringWithFormat:@"%@ ¥%@",model.quan_str,model.yhq_price];
        
        self.ticketLB.text=[NSString stringWithFormat:@" %@  ¥%@",model.quan_str,model.yhq_price];
        
        self.ticketLB.textColor=[UIColor colorWithHexString:model.quan_color];
        
        CGFloat inter_10=10;
        CGFloat ticketW=[self getWidthWithText:ticketString height:15 font:9];
        CGFloat estimateW=[self getWidthWithText:self.estimateLB.text height:15 font:9];
        if(ticketW<45){
           ticketW=45;
        }
        self.ticketImg.sd_layout
        .leftSpaceToView(self.goodsImg, inter_10).bottomSpaceToView(self.bgView, inter_10).widthIs(ticketW).heightIs(15);
        self.ticketLB.sd_layout
        .leftSpaceToView(self.ticketImg,0).rightSpaceToView(self.ticketImg,0).topSpaceToView(self.ticketImg, 0).bottomSpaceToView(self.ticketImg, 0);
        
        self.estimateLB.sd_layout
        .rightSpaceToView(self.bgView, inter_10).bottomSpaceToView(self.bgView, inter_10).widthIs(estimateW+10).heightIs(15);
        NSInteger yhqInt=[model.yhq integerValue];
        if (yhqInt==0) {
            self.ticketImg.hidden=YES;
            self.ticketLB.hidden=YES;
        }else{
            self.ticketImg.hidden=NO;
            self.ticketLB.hidden=NO;
        }
        if(model.someState==0){
            self.choiceBtn.selected=NO;
        }else{
            self.choiceBtn.selected=YES;
        }
    }
}

-(void)choiceBtnAction:(UIButton *)btn{
    btn.selected=!btn.selected;
    NSInteger state=0;
    if(btn.selected==YES){
       state=1;
    }else{
       state=0;
    }
    if ([self.delegate respondsToSelector:@selector(inchoiceSomeItemAction:withState:)]) {
        [self.delegate inchoiceSomeItemAction:self.indexPath withState:state];
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
