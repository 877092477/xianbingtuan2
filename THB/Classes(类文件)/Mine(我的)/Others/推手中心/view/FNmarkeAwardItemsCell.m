//
//  FNmarkeAwardItemsCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmarkeAwardItemsCell.h"

@implementation FNmarkeAwardItemsCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.stateImgView=[[UIImageView alloc]init];
    [self addSubview:self.stateImgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB]; 
    
    self.sumLB=[[UILabel alloc]init];
    [self addSubview:self.sumLB];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.titleLB.font=[UIFont systemFontOfSize:16];
    self.titleLB.textColor=RGB(24, 24, 24);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
   
    self.sumLB.font=[UIFont systemFontOfSize:12];
    self.sumLB.textColor=RGB(255, 40, 40);
    self.sumLB.textAlignment=NSTextAlignmentRight;
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 10).centerYEqualToView(self).widthIs(40).heightIs(40);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.imgView, 10).rightSpaceToView(self, 125).centerYEqualToView(self).heightIs(20);
    
    self.sumLB.sd_layout
    .rightSpaceToView(self, 15).centerYEqualToView(self).heightIs(20).widthIs(110);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(1);
    
    self.stateImgView.sd_layout
    .rightSpaceToView(self, 0).topSpaceToView(self, 0).widthIs(40).heightIs(40);
    
    self.imgView.clipsToBounds = YES;
    self.imgView.cornerRadius=20;
    self.lineView.backgroundColor=RGB(232, 232, 232);
    
}

-(void)setModel:(FNMarketCentreStoreItemModel *)model{
    _model=model;
    if(model){
        [self.imgView setUrlImg:model.img];
        self.titleLB.text=model.name;
        self.sumLB.text=model.commission;
        [self.stateImgView setUrlImg:model.icon];
    }
}
@end
