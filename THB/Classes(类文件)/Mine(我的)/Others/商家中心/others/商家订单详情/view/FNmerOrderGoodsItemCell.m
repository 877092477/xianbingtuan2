//
//  FNmerOrderGoodsItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerOrderGoodsItemCell.h"

@implementation FNmerOrderGoodsItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.headImgView=[[UIImageView alloc]init];
    [self.bgView addSubview:self.headImgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.nameLB];
    
    self.sumLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.sumLB];
    
    self.countLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.countLB];
    
    self.typeLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.typeLB];
    
    self.bgView.backgroundColor=[UIColor whiteColor]; 
    
    self.nameLB.font=[UIFont systemFontOfSize:13];
    self.nameLB.textColor=RGB(60, 60, 60);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.sumLB.font=[UIFont systemFontOfSize:14];
    self.sumLB.textColor=RGB(24, 24, 24);
    self.sumLB.textAlignment=NSTextAlignmentRight;
    
    self.countLB.font=[UIFont systemFontOfSize:12];
    self.countLB.textColor=RGB(24, 24, 24);
    self.countLB.textAlignment=NSTextAlignmentRight;
    
    self.typeLB.font=[UIFont systemFontOfSize:10];
    self.typeLB.textColor=RGB(254, 90, 90);
    self.typeLB.textAlignment=NSTextAlignmentCenter;
    self.typeLB.backgroundColor=RGB(255, 190, 190);
    self.typeLB.hidden=YES;
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 0).rightSpaceToView(self, 10).bottomSpaceToView(self, 0);
    
    self.headImgView.sd_layout
    .leftSpaceToView(self.bgView, 10).centerYEqualToView(self.bgView).heightIs(24).widthIs(24);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImgView, 10).centerYEqualToView(self.bgView).widthIs(150).heightIs(20);
    
    self.sumLB.sd_layout
    .rightSpaceToView(self.bgView, 10).centerYEqualToView(self.bgView).widthIs(80).heightIs(20);
    
    self.countLB.sd_layout
    .rightSpaceToView(self.sumLB, 5).centerYEqualToView(self.sumLB).widthIs(60).heightIs(20);
    
    self.typeLB.sd_layout
    .leftSpaceToView(self.bgView, 10).centerYEqualToView(self.bgView).widthIs(35).heightIs(15); 
    
}

-(void)setModel:(FNmerOrderGoodsItemHModel *)model{
    _model=model;
    if(model){
        if([model.type isEqualToString:@"goods"]){
            self.headImgView.hidden=NO;
            self.typeLB.hidden=YES;
            [self.headImgView setUrlImg:model.goods_img];
            self.nameLB.text=model.goods_title;
            self.sumLB.text=model.goods_price;
            self.countLB.text=model.count;
            self.nameLB.sd_layout
            .leftSpaceToView(self.bgView, 45).centerYEqualToView(self.bgView).widthIs(150).heightIs(20);
        }else{
            self.headImgView.hidden=YES;
            self.typeLB.hidden=NO;
            self.typeLB.text=model.str;
            self.nameLB.text=model.str1;
            self.sumLB.text=model.sum;
            self.typeLB.backgroundColor=[UIColor colorWithHexString:model.color];
            self.typeLB.textColor=[UIColor colorWithHexString:model.font_color];
            if(![model.font_color isEqualToString:@"FFFFFF"]){
                self.sumLB.textColor=[UIColor colorWithHexString:model.font_color];
            }else{
                self.sumLB.textColor=RGB(244, 47, 25);
            }
            CGFloat typeLBW=[model.str kr_getWidthWithTextHeight:15 font:10];
            if(typeLBW>40){
               typeLBW=40;
            }
            self.typeLB.sd_layout
            .leftSpaceToView(self.bgView, 10).centerYEqualToView(self.bgView).widthIs(typeLBW+10).heightIs(15);
            self.nameLB.sd_layout
            .leftSpaceToView(self.bgView, typeLBW+10+10+10).centerYEqualToView(self.bgView).widthIs(150).heightIs(20);
        }
    }
}
@end
