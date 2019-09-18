//
//  FNRushMealFooterNeView.m
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//餐号信息
#import "FNRushMealFooterNeView.h"

@implementation FNRushMealFooterNeView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) { 
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    bgView.sd_layout
    .topEqualToView(self).leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.centreLB= [[UILabel alloc]init];
    [self addSubview:self.centreLB];
    
    self.markTitle= [[UILabel alloc]init];
    self.markTitle.font=kFONT14;
    [self addSubview:self.markTitle];
    
    self.markLb = [[UILabel alloc]init];
    self.markLb.textColor=RGB(255, 155, 48);
    self.markLb.font=kFONT14;
    [self addSubview:self.markLb];
    
    self.reservedLb = [[UILabel alloc]init];
    [self addSubview:self.reservedLb];
    
    self.reservedPhoneLb = [[UILabel alloc]init];
    self.reservedPhoneLb.font=kFONT14;
    self.reservedPhoneLb.textColor=RGB(70, 187, 250);
    [self addSubview:self.reservedPhoneLb];
    
    self.duplicateBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0 , 80, 35)];
    //self.duplicateBtn.backgroundColor=[UIColor cyanColor];
    [self.duplicateBtn addTarget:self action:@selector(duplicateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.duplicateBtn];
    
    [self compositionFrame];
    self.backgroundColor=[UIColor whiteColor];
    
    
}
-(void)compositionFrame{
    CGFloat space_10=10;
    CGFloat space_20=20;
    CGFloat space_5=5;
    CGFloat space_2=5/2;
    self.centreLB.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(0.5);
    
    self.markTitle.sd_layout
    .topSpaceToView(self, space_10).leftSpaceToView(self, space_20).rightSpaceToView(self.centreLB, space_5).heightIs(20);
    
    self.markLb.sd_layout
    .topSpaceToView(self.markTitle, space_2).leftSpaceToView(self, space_20).rightSpaceToView(self.centreLB, space_5).heightIs(20);
    
    self.reservedLb.sd_layout
    .topSpaceToView(self, space_10).leftSpaceToView(self.centreLB, space_5).rightSpaceToView(self, space_10).heightIs(20);
    
    self.reservedPhoneLb.sd_layout
    .topSpaceToView(self.reservedLb, space_2).leftSpaceToView(self.centreLB, space_5).heightIs(20).widthIs(150);
    
    
    self.duplicateBtn.sd_layout
    .centerYEqualToView(self.reservedPhoneLb).leftSpaceToView(self.reservedPhoneLb, 7).widthIs(20).heightIs(20);
    
    
    
}
//-(void)setDicModel:(NSDictionary *)dicModel{
//    _dicModel=dicModel;
//    if(dicModel){
//        FNrushPurchaseNeModel *model=[FNrushPurchaseNeModel mj_objectWithKeyValues:dicModel];
//        FNrushBuyMsgModel *buymsg=[FNrushBuyMsgModel mj_objectWithKeyValues:model.buy_msg];
//        self.markTitle.text=@"自取餐号";
//        self.markLb.text=@"付款后查看";//@"144202120";
//        self.reservedLb.text=@"预留手机";
//        self.reservedPhoneLb.text=buymsg.phone;//@"131777889941";
//        [self.duplicateBtn setImage:IMAGE(@"pay_icon_amend") forState:UIControlStateNormal];
//
//        CGFloat reservedPhoneLbW =  [self getWidthWithText:self.reservedPhoneLb.text height:20 font:14];
//        CGFloat space_5=5;
//        self.reservedPhoneLb.sd_layout
//        .topSpaceToView(self.reservedLb, space_5).leftSpaceToView(self.centreLB, space_5).heightIs(20).widthIs(reservedPhoneLbW);
//
//        self.duplicateBtn.sd_layout
//        .centerYEqualToView(self.reservedPhoneLb).leftSpaceToView(self.reservedPhoneLb, 7).widthIs(20).heightIs(20);
//    }
//}
-(void)setBuymsg:(FNrushBuyMsgModel *)buymsg{
    _buymsg=buymsg;
    if(buymsg){
        self.markTitle.text=@"自取餐号";
        self.markLb.text=@"付款后查看";//@"144202120";
        self.reservedLb.text=@"预留手机";
        self.reservedPhoneLb.text=buymsg.phone;//@"131777889941";
        [self.duplicateBtn setImage:IMAGE(@"pay_icon_amend") forState:UIControlStateNormal];
        
        CGFloat reservedPhoneLbW =  [self getWidthWithText:self.reservedPhoneLb.text height:20 font:14];
        CGFloat space_5=5;
        self.reservedPhoneLb.sd_layout
        .topSpaceToView(self.reservedLb, space_5).leftSpaceToView(self.centreLB, space_5).heightIs(20).widthIs(reservedPhoneLbW);
        
        self.duplicateBtn.sd_layout
        .centerYEqualToView(self.reservedPhoneLb).leftSpaceToView(self.reservedPhoneLb, 7).widthIs(20).heightIs(20);
    }
}
-(void)duplicateBtnAction{
    if ([self.delegate respondsToSelector:@selector(storeCopyreaderCellphoneAction)]) {
        [self.delegate storeCopyreaderCellphoneAction];
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
