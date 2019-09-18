//
//  FNcandiesIncomeItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesIncomeItemCell.h"

@implementation FNcandiesIncomeItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.iconView=[[UIImageView alloc]init];
    [self addSubview:self.iconView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.priceLB=[[UILabel alloc]init];
    [self addSubview:self.priceLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.numberOfLines=2;
    self.titleLB.textColor=RGB(34, 34, 34);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:12];
    self.dateLB.textColor=RGB(168, 168, 168);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:12];
    self.hintLB.textColor=RGB(168, 168, 168);
    self.hintLB.textAlignment=NSTextAlignmentRight;
    
    self.priceLB.font=[UIFont systemFontOfSize:24];
    self.priceLB.textColor=RGB(34, 34, 34);
    self.priceLB.textAlignment=NSTextAlignmentRight;
    
    self.iconView.sd_layout
    .leftSpaceToView(self, 15).centerYEqualToView(self).widthIs(18).heightIs(18);
    
    self.priceLB.sd_layout
    .rightSpaceToView(self, 20).topSpaceToView(self, 25).heightIs(28).widthIs(90);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.iconView, 7).topSpaceToView(self, 30).heightIs(16).rightSpaceToView(self.priceLB, 10);
    
    self.hintLB.sd_layout
    .topSpaceToView(self, 55).heightIs(16).rightSpaceToView(self, 20).widthIs(90);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self.iconView, 7).topSpaceToView(self, 55).heightIs(14).rightSpaceToView(self.hintLB, 10);
    
    //self.titleLB.text=@"收入糖果成功";
    //self.priceLB.text=@"+ 24.24";
    //self.hintLB.text=@"转让糖果";
    //self.dateLB.text=@"2019-07-06 20:23";
}
-(void)setModel:(FNcandiesIncomeItemModel *)model{
    _model=model;
    if(model){
        [self.iconView setUrlImg:model.left_icon];
        NSString *jointStr=[NSString stringWithFormat:@"%@",model.title];
        self.titleLB.text=jointStr;
        self.priceLB.text=model.counts;
        self.hintLB.text=model.tips;
        self.dateLB.text=model.time;
        if([model.counts containsString:@"-"]){
           self.priceLB.textColor=RGB(244, 68, 68);
        }
        if([model.counts containsString:@"+"]){
            self.priceLB.textColor=RGB(34, 34, 34);
        }
        CGFloat priceLBW=[model.counts kr_getWidthWithTextHeight:28 font:24];
        if(priceLBW>100){
           priceLBW=100;
        }
        self.priceLB.sd_resetLayout
        .rightSpaceToView(self, 20).topSpaceToView(self, 25).heightIs(28).widthIs(priceLBW);
        
        CGFloat titleLBW=[jointStr kr_getWidthWithTextHeight:16 font:12];
        
        CGFloat gapWith= FNDeviceWidth-priceLBW-70;
        
        if(titleLBW<gapWith){
            self.titleLB.sd_resetLayout
            .leftSpaceToView(self.iconView, 7).topSpaceToView(self, 30).heightIs(16).rightSpaceToView(self.priceLB, 10);
        }else{
            self.titleLB.sd_resetLayout
            .leftSpaceToView(self.iconView, 7).topSpaceToView(self, 12).heightIs(32).rightSpaceToView(self.priceLB, 10);
        }
        
        
    }
}
@end
