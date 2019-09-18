//
//  FNcardDetailPeHeaderView.m
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcardDetailPeHeaderView.h"

@implementation FNcardDetailPeHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.bgImg=[[UIImageView alloc]init];
    self.bgImg.backgroundColor=RGB(246, 245, 245);
    [self addSubview:self.bgImg];
    
    self.headerImg=[[UIImageView alloc]init];
    self.headerImg.cornerRadius=58/2;
    self.headerImg.backgroundColor=RGB(246, 245, 245);
    [self addSubview:self.headerImg];
    
    self.titleLB=[[UILabel alloc]init];
    self.titleLB.font=kFONT14;
    self.titleLB.textColor=[UIColor whiteColor];
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.titleLB];
    
    self.sumLB=[[UILabel alloc]init];
    self.sumLB.font=kFONT13;
    self.sumLB.textColor=[UIColor whiteColor];
    self.sumLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.sumLB];
    
    self.dayTeView=[[FNcardheDayTeView alloc]init];
    self.dayTeView.frame=CGRectMake(0, 90, FNDeviceWidth, 60);
    self.dayTeView.backgroundColor=[UIColor clearColor];
    [self addSubview:self.dayTeView];
    
    self.hintLB=[[UILabel alloc]init];
    self.hintLB.font=kFONT14;
    self.hintLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.hintLB];
    
    self.leftLine=[[UIView alloc]init];
    self.leftLine.backgroundColor=RGB(104, 215, 255);
    [self addSubview:self.leftLine];
    
    self.rightLine=[[UIView alloc]init];
    self.rightLine.backgroundColor=RGB(104, 215, 255);
    [self addSubview:self.rightLine];
    
    self.baseLine=[[UIView alloc]init];
    self.baseLine.backgroundColor=RGB(245, 245, 245);
    [self addSubview:self.baseLine];
    
    [self incomposition];
    
}

-(void)incomposition{
    
    self.bgImg.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 55);
    
    self.headerImg.sd_layout
    .leftSpaceToView(self, 30).topSpaceToView(self, 20).heightIs(58).widthIs(58);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.headerImg, 10).rightSpaceToView(self, 10).topSpaceToView(self, 30).heightIs(20);
    
    self.sumLB.sd_layout
    .leftSpaceToView(self.headerImg,15).rightSpaceToView(self, 10).topSpaceToView(self.titleLB, 15).heightIs(20);
    
    self.dayTeView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 55).heightIs(60);
    
    self.hintLB.sd_layout
    .centerXEqualToView(self).bottomSpaceToView(self, 0).heightIs(55).widthIs(85);
    
    self.leftLine.sd_layout
    .centerYEqualToView(self.hintLB).rightSpaceToView(self.hintLB, 0).heightIs(2).widthIs(25);
    
    self.rightLine.sd_layout
    .centerYEqualToView(self.hintLB).leftSpaceToView(self.hintLB, 0).heightIs(2).widthIs(25);
    
    self.baseLine.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(1);
}
-(void)setModel:(FNDetailCardZoModel *)model{
    _model=model;
    if(model){
        [self.bgImg setUrlImg:model.bj_img];
        [self.headerImg setUrlImg:model.head_img];
        self.titleLB.text=model.nickname;
        self.sumLB.text=[NSString stringWithFormat:@"%@",model.str];
        self.hintLB.text=model.title;
        self.dayTeView.dataArr=model.sy_list;
    }
}
@end
