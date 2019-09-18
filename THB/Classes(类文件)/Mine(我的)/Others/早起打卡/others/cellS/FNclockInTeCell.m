//
//  FNclockInTeCell.m
//  THB
//
//  Created by Jimmy on 2019/2/27.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNclockInTeCell.h"

@implementation FNclockInTeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) { 
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.bgImg=[[UIImageView alloc]init];
    self.bgImg.backgroundColor=RGB(246, 245, 245);
    [self addSubview:self.bgImg];
    
    self.titleLB=[[UILabel alloc]init];
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=[UIColor whiteColor];
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.titleLB];
    
    self.countLB=[[UILabel alloc]init];
    self.countLB.font=[UIFont systemFontOfSize:14];
    self.countLB.textColor=[UIColor whiteColor];
    self.countLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.countLB];
    
    [self incomposition];
}
    
-(void)incomposition{
    CGFloat inter_5=5;
    
    self.bgImg.sd_layout
    .leftSpaceToView(self,inter_5).rightSpaceToView(self,inter_5).topSpaceToView(self, inter_5).bottomSpaceToView(self, inter_5);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, inter_5).rightSpaceToView(self, inter_5).bottomSpaceToView(self, 20).heightIs(20);
    
    self.countLB.sd_layout
    .leftSpaceToView(self, inter_5).rightSpaceToView(self, inter_5).topSpaceToView(self, 15).heightIs(25);
}

-(void)setModel:(FNclockInpayItemModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.str;
        self.countLB.text=[NSString stringWithFormat:@"%@",model.money];
        if(model.state==1){
           self.bgImg.image=IMAGE(@"FN_dkstimg");
           self.titleLB.textColor=[UIColor whiteColor];
           self.countLB.textColor=[UIColor whiteColor];
        }else{
           self.bgImg.image=IMAGE(@"");
           self.titleLB.textColor=[UIColor blackColor];
           self.countLB.textColor=[UIColor blackColor];
        }
        
    }
}
@end
