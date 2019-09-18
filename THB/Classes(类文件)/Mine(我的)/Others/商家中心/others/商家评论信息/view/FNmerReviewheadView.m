//
//  FNmerReviewheadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerReviewheadView.h"

@implementation FNmerReviewheadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgTopImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgTopImgView];
    
    self.headImgView=[[UIImageView alloc]init];
    [self addSubview:self.headImgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.flowLB=[[UILabel alloc]init];
    [self addSubview:self.flowLB];
    
    self.reviewLB=[[UILabel alloc]init];
    [self addSubview:self.reviewLB];
    
    self.oneLine=[[UIView alloc]init];
    [self addSubview:self.oneLine];
    
    self.twoLine=[[UIView alloc]init];
    [self addSubview:self.twoLine];
    
    self.nameLB.font=[UIFont systemFontOfSize:16];
    self.nameLB.textColor=[UIColor whiteColor];
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.flowLB.font=[UIFont systemFontOfSize:14];
    self.flowLB.textColor=[UIColor whiteColor];
    self.flowLB.textAlignment=NSTextAlignmentLeft;
    
    self.reviewLB.font=[UIFont systemFontOfSize:12];
    self.reviewLB.textColor=RGB(24,24,24);
    self.reviewLB.textAlignment=NSTextAlignmentLeft;
    
    self.oneLine.backgroundColor=RGB(246,245,245);
    self.twoLine.backgroundColor=RGB(246,245,245);
    
    self.bgTopImgView.sd_layout
    .topSpaceToView(self, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(110);
    
    self.headImgView.sd_layout
    .leftSpaceToView(self, 9).topSpaceToView(self, 32).heightIs(48).widthIs(48);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImgView, 12).topSpaceToView(self, 32).rightSpaceToView(self, 10).heightIs(20);
    
    self.flowLB.sd_layout
    .leftSpaceToView(self.headImgView, 12).topSpaceToView(self.nameLB, 8).rightSpaceToView(self, 10).heightIs(16);
    
    self.reviewLB.sd_layout
    .leftSpaceToView(self, 10).bottomSpaceToView(self, 13).rightSpaceToView(self, 10).heightIs(16);
    
    self.oneLine.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self.bgTopImgView, 0).rightSpaceToView(self, 0).heightIs(10);
    
    self.twoLine.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(1);
    
    self.headImgView.cornerRadius=48/2;
    self.headImgView.clipsToBounds = YES;
    self.headImgView.borderWidth=1;
    self.headImgView.borderColor = [UIColor whiteColor];
}

-(void)setModel:(FNmerReviewHeadModel *)model{
    _model=model;
    if(model){
        [self.bgTopImgView setUrlImg:model.top_bj];
        [self.headImgView setUrlImg:model.img];
        self.nameLB.text=model.store_name;
        self.flowLB.text=[NSString stringWithFormat:@"%@ %@    %@ %@",model.today_visitor_str,model.today_visitor,model.all_visitor_str,model.all_visitor];
    }
}
@end
