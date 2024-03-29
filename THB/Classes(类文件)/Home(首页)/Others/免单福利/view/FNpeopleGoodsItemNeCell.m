//
//  FNpeopleGoodsItemNeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//新人福利
#define kIphone6Width 375.0
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define kFit(x) (Screen_Width*((x)/kIphone6Width))
#import "FNpeopleGoodsItemNeCell.h"

@implementation FNpeopleGoodsItemNeCell
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
    self.goodsImageView=[UIImageView new];
    [self addSubview:self.goodsImageView];
    
    self.nameLB=[UILabel new];
    self.nameLB.textColor=FNBlackColor;
    self.nameLB.font=kFONT13;
    self.nameLB.numberOfLines=2;
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.nameLB];
    
    self.dsjLB=[UILabel new];
    self.dsjLB.textColor=FNBlackColor;
    self.dsjLB.font=[UIFont systemFontOfSize:kFit(12)];//kFONT12;
    self.dsjLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.dsjLB];
    
    
    self.priceLB=[UILabel new];
    [self.priceLB sizeToFit];
    self.priceLB.textColor=RGB(244, 62, 121);//FNBlackColor;
    self.priceLB.font=kFONT10;
    self.priceLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.priceLB];
    
    self.rawLB=[UILabel new];
    [self.rawLB sizeToFit];
    self.rawLB.textColor=RGB(129, 128, 129);
    self.rawLB.font=[UIFont systemFontOfSize:9];
    self.rawLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.rawLB];
    
    self.grabBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.grabBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    self.grabBtn.backgroundColor=RGB(244, 62, 121);
    self.grabBtn.titleLabel.font=kFONT12;
    self.grabBtn.cornerRadius=5;
    [self.grabBtn addTarget:self action:@selector(grabBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.grabBtn];
    
    self.amountLB=[UILabel new];
    [self.amountLB sizeToFit];
    self.amountLB.textColor=RGB(129, 128, 129);
    self.amountLB.font=[UIFont systemFontOfSize:9];
    self.amountLB.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.amountLB];
    
    
    self.line=[[UIView alloc]init];
    self.line.backgroundColor=RGB(129, 128, 129);
    [self addSubview:self.line];
    
    
    [self incomposition];
}

-(void)incomposition{
    CGFloat inter_20=20;
    CGFloat inter_10=10;
    CGFloat inter_5=5;
   
    
    self.goodsImageView.sd_layout
    .heightIs(100).widthIs(100).topSpaceToView(self, inter_10).centerXEqualToView(self);
    
    self.nameLB.sd_layout
    .topSpaceToView(self.goodsImageView, 15).rightSpaceToView(self, inter_10/2).leftSpaceToView(self, inter_10/2).heightIs(35);
    
    
    self.grabBtn.sd_layout
    .heightIs(22).leftSpaceToView(self, inter_10/2).bottomSpaceToView(self, inter_10).widthIs(45);
    
    self.amountLB.sd_layout
    .heightIs(12).rightSpaceToView(self, inter_10).bottomSpaceToView(self, inter_10);
    [self.amountLB setSingleLineAutoResizeWithMaxWidth:80];
    
    self.dsjLB.sd_layout
    .heightIs(20).leftSpaceToView(self, inter_10).bottomSpaceToView(self.grabBtn, inter_10).widthIs(48);
    
    self.priceLB.sd_layout
    .heightIs(20).widthIs(80).leftSpaceToView(self.dsjLB, inter_5).bottomEqualToView(self.dsjLB);
    
    self.rawLB.sd_layout
    .heightIs(12).rightSpaceToView(self, inter_10).bottomSpaceToView(self.grabBtn, inter_10+2);
    [self.rawLB setSingleLineAutoResizeWithMaxWidth:80];
    
    self.line.sd_layout
    .heightIs(1).widthIs(1).rightSpaceToView(self, 8).centerYEqualToView(self.rawLB);
    
}
-(void)setItemDictry:(NSDictionary *)itemDictry{
    _itemDictry=itemDictry;
    if(itemDictry){
        FNwelfDeListItemModel *model=[FNwelfDeListItemModel mj_objectWithKeyValues:itemDictry];
        CGFloat inter_20=20;
        CGFloat inter_10=10;
        
        self.nameLB.text=model.goods_title;//@"2018秋冬新款韩版假两件毛呢外套女中长款学生加厚流行毛呢大衣";
        
        NSString *typeString=@"¥";
        self.priceLB.text=[NSString stringWithFormat:@"%@%@",typeString,model.goods_price];//@"¥258";
        self.rawLB.text=[NSString stringWithFormat:@"%@%@",typeString,model.goods_cost_price];//;//@"¥358";
        [self.goodsImageView setUrlImg:model.goods_img];
        
        self.dsjLB.text=@"到手价:";
        CGFloat dsjW=  [self getWidthWithText:self.dsjLB.text height:15 font:kFit(12)];
        
        self.dsjLB.sd_layout
        .heightIs(15).leftSpaceToView(self, inter_10/2).bottomSpaceToView(self.grabBtn, inter_10).widthIs(dsjW);
        
        CGFloat priceW=  [self getWidthWithText:self.priceLB.text height:20 font:16];
        self.priceLB.sd_layout
        .heightIs(20).widthIs(priceW).leftSpaceToView(self.dsjLB, kFit(2.5)).bottomEqualToView(self.dsjLB);
        
        CGFloat rawLBW=  [self getWidthWithText:self.rawLB.text height:15 font:10];
        
        
        self.line.sd_layout
        .heightIs(1).widthIs(rawLBW+4).rightSpaceToView(self, 8).centerYEqualToView(self.rawLB);
        
        NSString* coupon = @"¥";
        NSString* price = model.goods_price;
        self.priceLB.text =[NSString stringWithFormat:@"%@%@",coupon,model.goods_price];
        [self.priceLB addSingleAttributed:@{NSFontAttributeName:[UIFont systemFontOfSize:kFit(16)]} ofRange:[self.priceLB.text rangeOfString:price]];//kFONT16
        
        [self.grabBtn setTitle:@"马上抢" forState:UIControlStateNormal];
        self.amountLB.text=[NSString stringWithFormat:@"已抢%@",model.goods_sales];
    }
    
}
-(void)grabBtnAction{
    if ([self.delegate respondsToSelector:@selector(itemGoodsItemClick:)]) {
        [self.delegate itemGoodsItemClick:self.itemDictry];
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
