//
//  FNmrketBillItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmrketBillItemCell.h"

@implementation FNmrketBillItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.sumLB=[[UILabel alloc]init];
    [self addSubview:self.sumLB];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.titleLB.font=[UIFont systemFontOfSize:13];
    self.titleLB.textColor=RGB(24, 24, 24);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:12];
    self.hintLB.textColor=RGB(196, 196, 196);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.sumLB.font=[UIFont systemFontOfSize:16];
    self.sumLB.textColor=RGB(255, 40, 40);
    self.sumLB.textAlignment=NSTextAlignmentRight;
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 15).centerYEqualToView(self).widthIs(30).heightIs(30);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.imgView, 10).rightSpaceToView(self, 135).topSpaceToView(self, 13).heightIs(17);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self.imgView, 10).bottomSpaceToView(self, 13).heightIs(13).widthIs(130);
    
    self.sumLB.sd_layout
    .rightSpaceToView(self, 15).centerYEqualToView(self).heightIs(20).widthIs(110);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 10).bottomSpaceToView(self, 0).rightSpaceToView(self, 10).heightIs(1);
    
    self.imgView.clipsToBounds = YES;
    self.imgView.cornerRadius=15;
    self.lineView.backgroundColor=RGB(232, 232, 232); 
}
-(void)setModel:(FNmarketBillItemModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.str;
        self.hintLB.text=model.time;
        self.sumLB.text=model.commission;
        [self.imgView setUrlImg:model.img];
    }
}
@end
