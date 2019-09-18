//
//  FNclockInTeHeaderView.m
//  THB
//
//  Created by Jimmy on 2019/2/27.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNclockInTeHeaderView.h"

@implementation FNclockInTeHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.dateLB=[[UILabel alloc]init];
    self.dateLB.font=kFONT13;
    self.dateLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.dateLB];
    
    self.titleLB=[[UILabel alloc]init];
    self.titleLB.font=kFONT14;
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.titleLB];
    
    [self incomposition];
    
}

-(void)incomposition{
    
    self.dateLB.sd_layout
    .leftSpaceToView(self,15).rightSpaceToView(self, 10).topSpaceToView(self, 15).heightIs(20);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).bottomSpaceToView(self, 10).heightIs(20);
    
}
-(void)setModel:(FNclockInZoModel *)model{
    _model=model;
    if(model){
       self.dateLB.text=model.str1;
       self.titleLB.text=model.str2;
    }
}
@end
