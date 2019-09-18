//
//  FNcanGrowUpDetailItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcanGrowUpDetailItemCell.h"

@implementation FNcanGrowUpDetailItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.lineView=[[UIImageView alloc]init];
    [self addSubview:self.lineView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.valueJoLB=[[UILabel alloc]init];
    [self addSubview:self.valueJoLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(27, 27, 27);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.valueJoLB.font=[UIFont systemFontOfSize:12];
    self.valueJoLB.textColor=RGB(212, 169, 80);
    self.valueJoLB.textAlignment=NSTextAlignmentRight;
    
    self.dateLB.font=[UIFont systemFontOfSize:12];
    self.dateLB.textColor=RGB(129, 130, 134);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.lineView.backgroundColor=RGB(238, 238, 238);
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 15).centerYEqualToView(self).widthIs(50).heightIs(50);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.imgView, 12).rightSpaceToView(self, 120).topSpaceToView(self, 25).heightIs(20);
    
    self.valueJoLB.sd_layout
    .rightSpaceToView(self, 15).centerYEqualToView(self).widthIs(100).heightIs(20);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self.imgView, 12).topSpaceToView(self.titleLB, 4).rightSpaceToView(self, 120).heightIs(14);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomEqualToView(self).heightIs(1);
    
    //self.titleLB.text=@"完成自购佣金+1";
    //self.dateLB.text=@"06-09 08:58";
    //self.valueJoLB.text=@"V力值+400 拷贝";
}

-(void)setModel:(FNcandiesGrowGardeDetailModel *)model{
    _model=model;
    if(model){
        [self.imgView setUrlImg:model.icon];
        self.titleLB.text=model.detail;//@"完成自购佣金+1";
        self.dateLB.text=model.date;//@"06-09 08:58";
        self.valueJoLB.text=model.counts_str;//@"V力值+400 ";
    }
}
@end
