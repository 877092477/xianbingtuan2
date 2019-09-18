//
//  FNcandiesConversionTopCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesConversionTopCell.h"

@implementation FNcandiesConversionTopCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.baseTitleLB=[[UILabel alloc]init];
    self.hintLB=[[UILabel alloc]init];
    self.centreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftline=[[UIView alloc]init];
    self.rightline=[[UIView alloc]init];
    [self addSubview:self.baseTitleLB];
    [self addSubview:self.hintLB];
    [self addSubview:self.centreBtn];
    [self addSubview:self.leftline];
    [self addSubview:self.rightline];
    
    self.candiesLB=[[UILabel alloc]init];
    self.candiesValLB=[[UILabel alloc]init];
    self.servantLB=[[UILabel alloc]init];
    self.servantValLB=[[UILabel alloc]init];
    [self addSubview:self.candiesLB];
    [self addSubview:self.candiesValLB];
    [self addSubview:self.servantLB];
    [self addSubview:self.servantValLB];
    
    self.baseTitleLB.font=kFONT12;
    self.baseTitleLB.textColor=[UIColor whiteColor];
    self.baseTitleLB.textAlignment=NSTextAlignmentCenter;
    
    self.hintLB.font=kFONT10;
    self.hintLB.textColor=[UIColor whiteColor];
    self.hintLB.textAlignment=NSTextAlignmentCenter;
    
    self.candiesLB.font=kFONT15;
    self.candiesLB.textColor=[UIColor whiteColor];
    self.candiesLB.textAlignment=NSTextAlignmentCenter;
    
    self.candiesValLB.font=kFONT17;
    self.candiesValLB.textColor=[UIColor whiteColor];
    self.candiesValLB.textAlignment=NSTextAlignmentCenter;
    
    self.servantLB.font=kFONT15;
    self.servantLB.textColor=[UIColor whiteColor];
    self.servantLB.textAlignment=NSTextAlignmentCenter;
    
    self.servantValLB.font=kFONT17;
    self.servantValLB.textColor=[UIColor whiteColor];
    self.servantValLB.textAlignment=NSTextAlignmentCenter;
    
    self.centreBtn.titleLabel.font=kFONT14;
    
    
    self.baseTitleLB.sd_layout
    .bottomSpaceToView(self, 24).widthIs(195).centerXEqualToView(self).heightIs(20);
    self.leftline.sd_layout
    .centerYEqualToView(self.baseTitleLB).heightIs(1).widthIs(50).rightSpaceToView(self.baseTitleLB, 2);
    self.rightline.sd_layout
    .centerYEqualToView(self.baseTitleLB).heightIs(1).widthIs(50).leftSpaceToView(self.baseTitleLB, 2);
    
    self.centreBtn.sd_layout
    .centerXEqualToView(self).widthIs(78).heightIs(78).topSpaceToView(self, SafeAreaTopHeight+5);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).heightIs(14).topSpaceToView(self.baseTitleLB, 2);
    
    
    CGFloat wEvens=(FNDeviceWidth-15)/2;
    self.candiesLB.sd_layout
    .leftSpaceToView(self, 5).widthIs(wEvens).heightIs(19).topSpaceToView(self, 140);
    
    self.candiesValLB.sd_layout
    .leftEqualToView(self.candiesLB).rightEqualToView(self.candiesLB).topSpaceToView(self.candiesLB, 10).heightIs(21);
    
    self.servantLB.sd_layout
    .rightSpaceToView(self, 5).widthIs(wEvens).heightIs(19).topSpaceToView(self, 140);
    
    self.servantValLB.sd_layout
    .leftEqualToView(self.servantLB).rightEqualToView(self.servantLB).topSpaceToView(self.servantLB, 10).heightIs(21);
    
}

-(void)setModel:(FNCandiesConversionModel *)model{
    _model=model;
    if(model){
        [self.centreBtn setTitle:model.dwqkb_task_exchange forState:UIControlStateNormal];
        [self.centreBtn setTitleColor:[UIColor colorWithHexString:model.dwqkb_task_exchange_color] forState:UIControlStateNormal];
        [self.centreBtn sd_setBackgroundImageWithURL:URL(model.dwqkb_task_exchange_bj) forState:UIControlStateNormal];
        
        self.candiesLB.text=model.dwqkb_task_dqqkb;
        self.candiesValLB.text=model.qkb_counts;
        self.servantLB.text=model.dwqkb_task_dqyj;
        self.servantValLB.text=model.commission;
        self.baseTitleLB.text=model.dwqkb_task_explain_str;
        self.hintLB.text=model.dwqkb_task_lq_explain;
        
        self.leftline.backgroundColor=[UIColor whiteColor];
        self.rightline.backgroundColor=[UIColor whiteColor];
    }
}
@end
