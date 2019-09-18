//
//  FNmerchantYjkbItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchantYjkbItemCell.h"

@implementation FNmerchantYjkbItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.sumLB=[[UILabel alloc]init];
    [self addSubview:self.sumLB];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.riseTitleLB=[[UILabel alloc]init];
    [self addSubview:self.riseTitleLB];
    
    self.stateImgView=[[UIImageView alloc]init];
    [self addSubview:self.stateImgView];
    
    self.sumLB.font=[UIFont systemFontOfSize:21];
    self.sumLB.textColor=RGB(255, 80, 51);
    self.sumLB.textAlignment=NSTextAlignmentCenter;
    
    self.nameLB.font=[UIFont systemFontOfSize:12];
    self.nameLB.textColor=RGB(255, 80, 51);
    self.nameLB.textAlignment=NSTextAlignmentCenter;
    
    self.riseTitleLB.font=[UIFont systemFontOfSize:11];
    self.riseTitleLB.textColor=RGB(140, 140, 140);
    self.riseTitleLB.textAlignment=NSTextAlignmentCenter;
    
    self.sumLB.sd_layout
    .topSpaceToView(self, 17).centerXEqualToView(self).heightIs(25).widthIs(90);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 5).rightSpaceToView(self, 5).topSpaceToView(self, 48).heightIs(16);
    
    self.riseTitleLB.sd_layout
    .leftSpaceToView(self, 5).rightSpaceToView(self, 5).bottomSpaceToView(self, 17).heightIs(15);
    
    self.stateImgView.sd_layout
    .leftSpaceToView(self.sumLB, 10).topSpaceToView(self, 20).widthIs(7).heightIs(8);

}

-(void)setDaModel:(FNMerchantItemMeModel *)daModel{
    _daModel=daModel;
    if(daModel){
        [self.stateImgView setUrlImg:daModel.icon];
        self.sumLB.text=daModel.number;
        self.nameLB.text=daModel.tips;
        self.riseTitleLB.text=daModel.yesterday_add;
        
        self.sumLB.textColor=[UIColor colorWithHexString:daModel.color];
        self.nameLB.textColor=[UIColor colorWithHexString:daModel.color];
        self.riseTitleLB.textColor=[UIColor colorWithHexString:daModel.yesterday_add_color];
        
        CGFloat sumLBW=[self.sumLB.text kr_getWidthWithTextHeight:25 font:21];
        if(sumLBW>100){
           sumLBW=100;
        }
        self.sumLB.sd_layout
        .topSpaceToView(self, 17).centerXEqualToView(self).heightIs(25).widthIs(sumLBW);
        self.stateImgView.sd_layout
        .leftSpaceToView(self.sumLB, 10).topSpaceToView(self, 20).widthIs(7).heightIs(8);
    }
}
@end
