//
//  FNstoreCommodityDaNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNstoreCommodityDaNeCell.h"

@implementation FNstoreCommodityDaNeCell

-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    
    //商品图片
    self.goodsImage=[UIImageView new];
    [self.contentView addSubview:self.goodsImage];
    
    //商品名字
    self.goodsName=[UILabel new];
    self.goodsName.textColor=[UIColor blackColor];
    self.goodsName.font=kFONT14;
    [self.goodsName sizeToFit];
    [self.contentView addSubview:self.goodsName];
    
    //商品简介
    self.goodsIntro=[UILabel new];
    self.goodsIntro.textColor=[UIColor grayColor];
    self.goodsIntro.font=kFONT12;
    [self.goodsIntro sizeToFit];
    [self.contentView addSubview:self.goodsIntro];
    
    //营业时间
    self.doBusinessDate=[UILabel new];
    self.doBusinessDate.textColor=[UIColor grayColor];
    self.doBusinessDate.font=kFONT12;
    [self.doBusinessDate sizeToFit];
    [self.contentView addSubview:self.doBusinessDate];
    
    //商品价格
    self.priceLB=[UILabel new];
    self.priceLB.textColor=[UIColor redColor];
    self.priceLB.font=kFONT14;
    [self.priceLB sizeToFit];
    [self.contentView addSubview:self.priceLB];
    
    //商品原价
    self.originalCost=[UILabel new];
    self.originalCost.textColor=[UIColor grayColor];
    self.originalCost.font=kFONT12;
    [self.originalCost sizeToFit];
    [self.contentView addSubview:self.originalCost];
    
    //加
    self.addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.addBtn];
    
    //减
    self.minusBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.minusBtn addTarget:self action:@selector(minusBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.minusBtn];
    
    //购买数量
    self.amountLB=[UILabel new];
    self.amountLB.textColor=[UIColor blackColor];
    self.amountLB.font=kFONT12;
    [self.amountLB sizeToFit];
    self.amountLB.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.amountLB];
    
    self.lineLB=[UILabel new];
    self.lineLB.backgroundColor=FNColor(244, 244, 244);
    [self.contentView addSubview:self.lineLB];
    
    [self initPlaceSubviews];
    
    
}
#pragma mark - initPlaceSubviews
- (void)initPlaceSubviews {
    CGFloat space_10=10;
    CGFloat space_7=5;
    
    self.goodsImage.sd_layout
    .centerYEqualToView(self.contentView).leftSpaceToView(self.contentView, space_10).widthIs(95).heightIs(95);
    
    self.goodsName.sd_layout.topEqualToView(self.goodsImage).heightIs(20).leftSpaceToView(self.goodsImage, space_10).rightSpaceToView(self.contentView, space_10);
    
    self.goodsIntro.sd_layout.heightIs(20).leftSpaceToView(self.goodsImage, space_10).rightSpaceToView(self.contentView, space_10).topSpaceToView(self.goodsName, space_7);
    
    self.doBusinessDate.sd_layout.heightIs(20).leftSpaceToView(self.goodsImage, space_10).rightSpaceToView(self.contentView, space_10).topSpaceToView(self.goodsIntro, space_7);
    
    self.priceLB.sd_layout.heightIs(20).leftSpaceToView(self.goodsImage, space_10).topSpaceToView(self.doBusinessDate, space_7);
    [self.priceLB setSingleLineAutoResizeWithMaxWidth:90];
    
    self.originalCost.sd_layout.heightIs(20).leftSpaceToView(self.priceLB, space_10).topSpaceToView(self.doBusinessDate, space_7);
    [self.originalCost setSingleLineAutoResizeWithMaxWidth:90];
    
    self.addBtn.sd_layout.heightIs(25).widthIs(25).rightSpaceToView(self.contentView, space_10).bottomSpaceToView(self.contentView, space_10);
    
    self.amountLB.sd_layout.heightIs(20).widthIs(30).rightSpaceToView(self.addBtn, 0).centerYEqualToView(self.addBtn);
    
    self.minusBtn.sd_layout.heightIs(25).widthIs(25).rightSpaceToView(self.amountLB, 0).bottomSpaceToView(self.contentView, space_10); 
    
    self.lineLB.sd_layout.heightIs(1).leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0);
    
}
-(void)setDicModel:(NSDictionary *)dicModel{
    _dicModel=dicModel;
    if(dicModel){
//        FNstorePaveItemModel *model=[FNstorePaveItemModel mj_objectWithKeyValues:dicModel];
//        [self.goodsImage  setUrlImg:model.goods_img];
//        self.goodsName.text=model.goods_title;//@"麻辣火锅椒盐全虾宴";
//        self.goodsIntro.text=model.describe;//@"皮皮虾、小龙虾、螃蟹、秋刀鱼、海螺、生蚝、扇贝";
//        self.doBusinessDate.text=[NSString stringWithFormat:@"%@ %@-%@",model.day_str,model.start_hour,model.end_hour];//@"周一至周日  12:00-18:00";
//        self.priceLB.text=[NSString stringWithFormat:@"¥%@",model.goods_price];//@"¥78";
//        self.originalCost.text=[NSString stringWithFormat:@"¥%@",model.goods_cost_price];//@"¥129";
//        self.amountLB.text=@"0";
//        [self.addBtn setImage:[UIImage imageNamed:@"details_cion_add"] forState:UIControlStateNormal];
//        [self.minusBtn setImage:[UIImage imageNamed:@"details_cion_reduce"] forState:UIControlStateNormal];
        
        //NSString* price = [NSString stringWithFormat:@"%.2lf",[model.goods_price floatValue]];
        //self.qhPriceLabel.text = [NSString stringWithFormat:@"券后¥%@",price];
        //[self.rewardLB addSingleAttributed:@{NSFontAttributeName:kFONT16} ofRange:[self.rewardLB.text rangeOfString:price]];
    }
}
-(void)setModel:(FNstorePaveItemModel *)model{
    _model=model;
    if (model) {
        [self.goodsImage  setUrlImg:model.goods_img];
        self.goodsName.text=model.goods_title;//@"麻辣火锅椒盐全虾宴";
        self.goodsIntro.text=model.describe;//@"皮皮虾、小龙虾、螃蟹、秋刀鱼、海螺、生蚝、扇贝";
        self.doBusinessDate.text=[NSString stringWithFormat:@"%@ %@-%@",model.day_str,model.start_hour,model.end_hour];//@"周一至周日  12:00-18:00";
        self.priceLB.text=[NSString stringWithFormat:@"¥%@",model.goods_price];//@"¥78";
        self.originalCost.text=[NSString stringWithFormat:@"¥%@",model.goods_cost_price];//@"¥129";
        self.amountLB.text=[NSString stringWithFormat:@"%ld",(long)model.count];//@"0";
        if (model.count==0) {
            self.minusBtn.hidden=YES;
            self.amountLB.hidden=YES;
        }else if(model.count>0){
            self.minusBtn.hidden=NO;
            self.amountLB.hidden=NO;
        }
        [self.addBtn setImage:[UIImage imageNamed:@"details_cion_add"] forState:UIControlStateNormal];
        [self.minusBtn setImage:[UIImage imageNamed:@"details_cion_reduce"] forState:UIControlStateNormal];
    }
}
-(void)minusBtnAction{
    if ([self.delegate respondsToSelector:@selector(storeCommodityDecrementAction:)]) {
        [self.delegate storeCommodityDecrementAction:self.indexPath];
    }
}
-(void)addBtnAction{
    if ([self.delegate respondsToSelector:@selector(storeCommodityAttachAmountAction:)]) {
        [self.delegate storeCommodityAttachAmountAction:self.indexPath];
    }
}
//- (void)addSingleAttributed:(NSDictionary *)att ofRange:(NSRange)range{
//    if (self.text == nil || self.text.length <=0) {
//        return;
//    }
//    NSMutableAttributedString* matt = [[NSMutableAttributedString alloc]initWithString:self.text];
//    [matt addAttributes:att range:range];
//    self.attributedText = matt;
//}
@end
