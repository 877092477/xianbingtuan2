//
//  FNcanIncomeDanCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcanIncomeDanCell.h"

@implementation FNcanIncomeDanCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    
//    self.titleLB=[[UILabel alloc]init];
//    [self addSubview:self.titleLB];
    
    self.priceLB=[[UILabel alloc]init];
    [self addSubview:self.priceLB];
    
    self.bgImgView.contentMode=UIViewContentModeScaleAspectFill;
    self.bgImgView.clipsToBounds = YES;
    
//    self.titleLB.font=[UIFont systemFontOfSize:15];
//    self.titleLB.textColor=RGB(51, 51, 51);
//    self.titleLB.textAlignment=NSTextAlignmentLeft; 
   
    
    self.priceLB.font=[UIFont systemFontOfSize:20];
    self.priceLB.textColor=[UIColor whiteColor];
    self.priceLB.textAlignment=NSTextAlignmentCenter;
  
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    
    self.priceLB.sd_layout
    .leftSpaceToView(self, 15).bottomSpaceToView(self, 27).heightIs(22).rightSpaceToView(self, 15);
    
  
    
} 

@end
