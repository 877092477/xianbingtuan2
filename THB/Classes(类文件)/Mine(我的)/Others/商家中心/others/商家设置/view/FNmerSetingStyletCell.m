//
//  FNmerSetingStyletCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerSetingStyletCell.h"

@implementation FNmerSetingStyletCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.leftTitleLB=[[UILabel alloc]init];
    [self addSubview:self.leftTitleLB];
    
    self.bottomLB=[[UILabel alloc]init];
    [self addSubview:self.bottomLB];
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    
    self.leftTitleLB.font=[UIFont systemFontOfSize:14];
    self.leftTitleLB.textColor=RGB(60, 60, 60);
    self.leftTitleLB.textAlignment=NSTextAlignmentLeft;
    
    self.bottomLB.font=[UIFont systemFontOfSize:11];
    self.bottomLB.textColor=RGB(153, 153, 153);
    self.bottomLB.textAlignment=NSTextAlignmentLeft;
    
    self.leftTitleLB.sd_layout
    .leftSpaceToView(self, 20).topSpaceToView(self, 0).widthIs(70).heightIs(53);
    
    self.bottomLB.sd_layout
    .leftSpaceToView(self, 20).rightSpaceToView(self, 20).heightIs(27).bottomSpaceToView(self, 10);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 20).centerYEqualToView(self.leftTitleLB).widthIs(34).heightIs(22);
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    self.lineView.backgroundColor=RGB(250, 250, 250);
    self.lineView.sd_layout
    .leftSpaceToView(self, 20).rightSpaceToView(self, 0).bottomSpaceToView(self, 39).heightIs(1);
    
    
}

-(void)setModel:(FNmerSetingsItemModel *)model{
    _model=model;
    if(model){
        self.leftTitleLB.text=model.leftStr;
        self.bottomLB.text=model.bottomhint;
       
        if(model.rightState==0){
           [self.rightBtn setBackgroundImage:IMAGE(@"FN_xdSJ_gbimg") forState:UIControlStateNormal];
        }else{
           [self.rightBtn setBackgroundImage:IMAGE(@"FN_xdSJ_kqim") forState:UIControlStateNormal];
        }
    }
}
@end
