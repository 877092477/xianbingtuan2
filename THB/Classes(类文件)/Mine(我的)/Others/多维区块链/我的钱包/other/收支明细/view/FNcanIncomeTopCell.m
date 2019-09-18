//
//  FNcanIncomeTopCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcanIncomeTopCell.h"

@implementation FNcanIncomeTopCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    //self.bgImgView=[[UIImageView alloc]init];
    //[self addSubview:self.bgImgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.priceLB=[[UILabel alloc]init];
    [self addSubview:self.priceLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:12];
    self.hintLB.textColor=RGB(51, 51, 51);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.priceLB.font=[UIFont systemFontOfSize:44];
    self.priceLB.textColor=RGB(51, 51, 51);
    self.priceLB.textAlignment=NSTextAlignmentLeft;
    
    self.incomeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.incomeBtn];
    
    self.baseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.baseBtn];
    
    [self.incomeBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [self.baseBtn setTitleColor:RGB(116, 93, 250) forState:UIControlStateNormal];
    self.incomeBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    self.incomeBtn.titleLabel.font=kFONT12;
    self.baseBtn.titleLabel.font=kFONT14;
    
    //self.bgImgView.sd_layout
    //.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).heightIs(218);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 30).topSpaceToView(self, 80).heightIs(16).rightSpaceToView(self, 10);
    
    self.priceLB.sd_layout
    .leftSpaceToView(self, 30).topSpaceToView(self.titleLB, 5).heightIs(46).rightSpaceToView(self, 65);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 30).topSpaceToView(self.priceLB, 12).heightIs(16).rightSpaceToView(self, 30);
    
    self.incomeBtn.sd_layout
    .rightSpaceToView(self, 9).topSpaceToView(self, 118).heightIs(18).widthIs(60);
    
    self.baseBtn.sd_layout
    .leftSpaceToView(self, 30).rightSpaceToView(self, 30).bottomSpaceToView(self, 0).heightIs(65);
    self.baseBtn.imageView.sd_layout
    .leftSpaceToView(self.baseBtn, 10).bottomSpaceToView(self.baseBtn, 0).topSpaceToView(self.baseBtn, 0).rightSpaceToView(self.baseBtn, 10);
    
    self.baseBtn.titleLabel.sd_layout
    .centerYEqualToView(self.baseBtn).leftSpaceToView(self.baseBtn, 70).rightSpaceToView(self.baseBtn, 70).heightIs(30);
    self.baseBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.baseBtn.adjustsImageWhenHighlighted = NO;
}

-(void)setModel:(FNcandiesIncomeModel *)model{
    _model=model;
    if(model){
        //[self.bgImgView setUrlImg:model.top_bg];
        self.titleLB.text=model.all_count_str;
        self.priceLB.text=model.qkb_count;
        self.hintLB.text=model.yesterday_income;
        self.titleLB.textColor=[UIColor colorWithHexString:model.top_color];
        self.priceLB.textColor=[UIColor colorWithHexString:model.top_color];
        self.hintLB.textColor=[UIColor colorWithHexString:model.top_color];
        [self.incomeBtn setTitleColor:[UIColor colorWithHexString:model.top_color] forState:UIControlStateNormal];
        [self.incomeBtn setTitle:model.duiduan_btn forState:UIControlStateNormal];
        [self.baseBtn sd_setImageWithURL:URL(model.date_bg) forState:UIControlStateNormal];
        [self.baseBtn setTitle:@"点击选择日期" forState:UIControlStateNormal];
        [self.baseBtn setTitleColor:RGB(43, 42, 49) forState:UIControlStateNormal];
    }
}
@end
