//
//  FNmerchantOrderItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchantOrderItemCell.h"

@implementation FNmerchantOrderItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.headImgView=[[UIImageView alloc]init];
    [self addSubview:self.headImgView];
     
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.sumLB=[[UILabel alloc]init];
    [self addSubview:self.sumLB];
    
    self.nameLB.font=[UIFont systemFontOfSize:13];
    self.nameLB.textColor=RGB(24, 24, 24);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:11];
    self.dateLB.textColor=RGB(140, 140, 140);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.sumLB.font=[UIFont systemFontOfSize:18];
    self.sumLB.textColor=RGB(254, 52, 52);
    self.sumLB.textAlignment=NSTextAlignmentRight;
    
    self.headImgView.sd_layout
    .leftSpaceToView(self, 10).centerYEqualToView(self).widthIs(31).heightIs(31);
    self.headImgView.cornerRadius=2;
    
    self.sumLB.sd_layout
    .rightSpaceToView(self, 15).centerYEqualToView(self).widthIs(90).heightIs(20);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImgView, 15).topEqualToView(self.headImgView).rightSpaceToView(self.sumLB, 10).heightIs(16);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self.headImgView, 15).topSpaceToView(self.nameLB, 2).rightSpaceToView(self.sumLB, 10).heightIs(14);
    
    
    
}
-(void)setDaModel:(FNMerchantItemMeModel *)daModel{
    _daModel=daModel;
    if(daModel){
        [self.headImgView setUrlImg:daModel.img];
        self.nameLB.text=daModel.title;
        self.dateLB.text=daModel.time;
        self.sumLB.text=daModel.price;
        self.nameLB.textColor=[UIColor colorWithHexString:daModel.title_color];
        self.dateLB.textColor=[UIColor colorWithHexString:daModel.time_color];
        self.sumLB.textColor=[UIColor colorWithHexString:daModel.price_color];
    }
}
@end
