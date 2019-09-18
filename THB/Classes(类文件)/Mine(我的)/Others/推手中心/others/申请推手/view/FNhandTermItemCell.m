//
//  FNhandTermItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNhandTermItemCell.h"

@implementation FNhandTermItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    
    self.titleImgView=[[UIImageView alloc]init];
    [self addSubview:self.titleImgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=RGB(153, 105, 48);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 10).rightSpaceToView(self, 10).bottomSpaceToView(self, 0);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 47).topSpaceToView(self, 0).rightSpaceToView(self, 122).bottomSpaceToView(self, 0);
    
    self.titleImgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 32).rightSpaceToView(self, 10).heightIs(20);
    
    self.bgImgView.clipsToBounds = YES;
    self.bgImgView.contentMode=UIViewContentModeScaleToFill;
    
    self.titleImgView.clipsToBounds = YES;
    self.titleImgView.contentMode=UIViewContentModeScaleAspectFit;
    
    self.listView=[[FNhandConditionsView alloc]init];
    self.listView.frame=CGRectMake(47, 65, FNDeviceWidth-94, 50);
    self.listView.backgroundColor=[UIColor clearColor];
    [self addSubview:self.listView];
    
    self.listView.sd_layout
    .leftSpaceToView(self, 47).rightSpaceToView(self, 47).topSpaceToView(self, 65).bottomSpaceToView(self, 20);
    
}
-(void)setModel:(FNHandSlapdModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setUrlImg:model.condition_bg];
        [self.titleImgView setUrlImg:model.condition_title_img];
        self.listView.dataArr=model.condition;
        self.listView.sd_layout
        .leftSpaceToView(self, 47).rightSpaceToView(self, 47).topSpaceToView(self, 65).bottomSpaceToView(self, 20);
    }
}
@end
