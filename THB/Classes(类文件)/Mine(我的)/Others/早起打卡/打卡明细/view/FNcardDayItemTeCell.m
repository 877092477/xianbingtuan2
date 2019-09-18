//
//  FNcardDayItemTeCell.m
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcardDayItemTeCell.h"

@implementation FNcardDayItemTeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews
{
    self.titleLB=[[UILabel alloc]init];
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    self.titleLB.textColor=[UIColor whiteColor];
    [self addSubview:self.titleLB];
    
    self.sumLB=[[UILabel alloc]init];
    self.sumLB.font=[UIFont systemFontOfSize:12];
    self.sumLB.textAlignment=NSTextAlignmentCenter;
    self.sumLB.textColor=[UIColor whiteColor];
    [self addSubview:self.sumLB];
    
    [self incomposition];
}

-(void)incomposition{
    
    self.sumLB.sd_layout
    .leftSpaceToView(self, 2).rightSpaceToView(self, 2).topSpaceToView(self, 5).heightIs(17);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 2).rightSpaceToView(self, 2).bottomSpaceToView(self, 20).heightIs(15);
    
}

-(void)setModel:(FNDayCardZoModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.str;
        self.sumLB.text=model.val;
    }
}
@end
