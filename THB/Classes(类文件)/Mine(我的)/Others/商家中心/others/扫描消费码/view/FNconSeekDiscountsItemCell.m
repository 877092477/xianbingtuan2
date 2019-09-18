//
//  FNconSeekDiscountsItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNconSeekDiscountsItemCell.h"

@implementation FNconSeekDiscountsItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.nameLB];
    
    self.sumLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.sumLB];
    
    self.discountsLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.discountsLB];
    
    self.bgView.backgroundColor=[UIColor whiteColor];
    
    self.nameLB.font=[UIFont systemFontOfSize:10];
    self.nameLB.textColor=RGB(254, 90, 90);
    self.nameLB.textAlignment=NSTextAlignmentCenter;
    
    self.sumLB.font=[UIFont systemFontOfSize:12];
    self.sumLB.textColor=RGB(244, 47, 25);
    self.sumLB.textAlignment=NSTextAlignmentRight;
    
    self.discountsLB.font=[UIFont systemFontOfSize:12];
    self.discountsLB.textColor=RGB(24, 24, 24);
    self.discountsLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 0).rightSpaceToView(self, 10).bottomSpaceToView(self, 0);
    
    self.sumLB.sd_layout
    .rightSpaceToView(self.bgView, 10).centerYEqualToView(self.bgView).widthIs(90).heightIs(14);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.bgView, 10).centerYEqualToView(self.bgView).widthIs(35).heightIs(14);
    
    self.discountsLB.sd_layout
    .leftSpaceToView(self.nameLB, 13).rightSpaceToView(self.sumLB, 5).centerYEqualToView(self.bgView).heightIs(16);
    
}

-(void)setModel:(FNmerConsumeGoodsItemModel *)model{
    _model=model;
    if(model){
        self.nameLB.text=model.str;
        self.sumLB.text=model.sum;
        self.discountsLB.text=model.str1;
        self.nameLB.backgroundColor=[UIColor colorWithHexString:model.color];
        self.nameLB.textColor=[UIColor colorWithHexString:model.font_color];
        self.nameLB.cornerRadius=2;
        CGFloat nameLBWide=[self.nameLB.text kr_getWidthWithTextHeight:14 font:10];
        if(nameLBWide>90){
            nameLBWide=90;
        }
        self.nameLB.sd_resetLayout
        .leftSpaceToView(self.bgView, 10).centerYEqualToView(self.bgView).widthIs(nameLBWide+16).heightIs(14);
        self.discountsLB.sd_resetLayout
        .leftSpaceToView(self.nameLB, 13).rightSpaceToView(self.sumLB, 5).centerYEqualToView(self.bgView).heightIs(16);
    }
}
@end
