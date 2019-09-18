//
//  FNclockInPayHeaderView.m
//  THB
//
//  Created by Jimmy on 2019/2/27.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNclockInPayHeaderView.h"

@implementation FNclockInPayHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.hintLB=[[UILabel alloc]init];
    self.hintLB.font=kFONT11;
    self.hintLB.textColor=RGB(255,41,30);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.hintLB];
    
    self.titleLB=[[UILabel alloc]init];
    self.titleLB.font=kFONT14;
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.titleLB];
    
    [self incomposition];
    
}

-(void)incomposition{
    
    self.hintLB.sd_layout
    .leftSpaceToView(self,15).rightSpaceToView(self, 10).topSpaceToView(self, 0).heightIs(20);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).rightSpaceToView(self, 10).bottomSpaceToView(self, 5).heightIs(20);
    
}
-(void)setModel:(FNclockInZoModel *)model{
    _model=model;
    if(model){
        self.hintLB.text=model.str3;
        self.titleLB.text=model.str4;
    }
}
@end
