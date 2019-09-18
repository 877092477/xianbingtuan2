//
//  FNcanGrowUpStayItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcanGrowUpStayItemCell.h"

@implementation FNcanGrowUpStayItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    
    self.stateImgView=[[UIImageView alloc]init];
    [self addSubview:self.stateImgView];
    
    self.valueJoLB=[[UILabel alloc]init];
    [self addSubview:self.valueJoLB];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=RGB(46,45,51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.valueJoLB.font=[UIFont systemFontOfSize:30];
    self.valueJoLB.textColor=RGB(187,187,190);
    self.valueJoLB.textAlignment=NSTextAlignmentLeft;
    
    self.stateImgView.cornerRadius=8/2;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 5).topSpaceToView(self, 5).rightSpaceToView(self, 5).bottomSpaceToView(self, 5);
    
    self.stateImgView.sd_layout
    .leftSpaceToView(self, 37).topSpaceToView(self, 25).widthIs(8).heightIs(8);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.stateImgView, 10).centerYEqualToView(self.stateImgView).rightSpaceToView(self, 150).heightIs(16);
    
    self.valueJoLB.sd_layout
    .leftSpaceToView(self, 40).topSpaceToView(self.stateImgView, 15).rightSpaceToView(self, 120).heightIs(34);
    
    
    //self.bgImgView.backgroundColor=[UIColor whiteColor];
    self.bgImgView.cornerRadius=10;
    self.bgImgView.clipsToBounds = YES;
    
}
-(void)setModel:(FNcandiesGrowModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setUrlImg:model.dwqkb_grow_frozen_bj];
        self.stateImgView.backgroundColor=RGB(240, 211, 55);
        self.titleLB.text=model.dwqkb_grow_frozen_tips;//@"待冻结成长值";
        self.valueJoLB.text=model.frozen_value;//@"2254.23";
        self.titleLB.textColor=[UIColor colorWithHexString:model.dwqkb_grow_frozen_tips_color];
        self.valueJoLB.textColor=[UIColor colorWithHexString:model.dwqkb_grow_frozen_color];
    }
}
@end
