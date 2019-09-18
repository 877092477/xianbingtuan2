//
//  FNpredictTimesCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNpredictTimesCell.h"

@implementation FNpredictTimesCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.titleDateLB=[[UILabel alloc]init];
    [self addSubview:self.titleDateLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    
    self.lineView.backgroundColor=RGB(250, 250, 250);
    
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.titleDateLB.font=[UIFont systemFontOfSize:14];
    self.titleDateLB.textColor=RGB(51, 51, 51);
    self.titleDateLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:12];
    self.hintLB.textColor=RGB(153, 153, 153);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 44).heightIs(1);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).rightSpaceToView(self, 15).heightIs(20).topSpaceToView(self, 11);
    
    self.titleDateLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self.lineView, 8).heightIs(18).rightSpaceToView(self, 100);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self.lineView, 27).heightIs(18).rightSpaceToView(self, 100);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 10).widthIs(90).heightIs(22).bottomSpaceToView(self, 16);
    
    self.rightBtn.imageView.sd_layout
    .rightSpaceToView(self.rightBtn, 0).centerYEqualToView(self.rightBtn).widthIs(6).heightIs(11);
    
    self.rightBtn.titleLabel.sd_layout
    .leftSpaceToView(self.rightBtn, 2).rightSpaceToView(self.rightBtn, 20).heightIs(18).centerYEqualToView(self.rightBtn);
    
    self.rightBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    self.rightBtn.titleLabel.textAlignment=NSTextAlignmentRight; 
    [self.rightBtn setImage:IMAGE(@"FJ_xY_img") forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)rightBtnAction{
    if ([self.delegate respondsToSelector:@selector(didpredictTimesItemAction:)]) {
        [self.delegate didpredictTimesItemAction:self.index];
    }
}

-(void)setModel:(FNpredictDeliveryTimeModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.title;
        self.titleDateLB.text=model.dateTitle;
        if([model.leftHint kr_isNotEmpty]){
           self.hintLB.text=model.leftHint;
        }
        if([model.islLeftHint integerValue]==1){
            self.titleDateLB.sd_resetLayout
            .leftSpaceToView(self, 15).topSpaceToView(self.lineView, 8).heightIs(18).rightSpaceToView(self, 100);
            
            self.hintLB.sd_resetLayout
            .leftSpaceToView(self, 15).topSpaceToView(self.lineView, 27).heightIs(18).rightSpaceToView(self, 100);
        }else{
            self.titleDateLB.sd_resetLayout
            .leftSpaceToView(self, 15).bottomSpaceToView(self, 16).heightIs(18).rightSpaceToView(self, 100);
            
            self.hintLB.sd_resetLayout
            .leftSpaceToView(self, 15).bottomSpaceToView(self, 0).heightIs(0).widthIs(0);
        } 
        if([model.rightValue kr_isNotEmpty]){
           [self.rightBtn setTitle:model.rightValue forState:UIControlStateNormal];
        }else{
           [self.rightBtn setTitle:model.rightHint forState:UIControlStateNormal];
        }
        [self.rightBtn setImage:IMAGE(@"FJ_xY_img") forState:UIControlStateNormal];
    }
}
@end
