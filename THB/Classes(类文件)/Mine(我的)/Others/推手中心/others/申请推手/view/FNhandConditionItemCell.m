//
//  FNhandConditionItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNhandConditionItemCell.h"

@implementation FNhandConditionItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    
    self.stateImgView=[[UIImageView alloc]init];
    [self addSubview:self.stateImgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=RGB(153, 105, 48);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 0).rightSpaceToView(self, 10).bottomSpaceToView(self, 0);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 70).bottomSpaceToView(self, 0);
    
    self.stateImgView.sd_layout
    .centerYEqualToView(self).rightSpaceToView(self, 0).widthIs(66).heightIs(43);
    
    self.bgImgView.clipsToBounds = YES;
    self.bgImgView.contentMode=UIViewContentModeScaleAspectFill;
    
    self.stateImgView.clipsToBounds = YES;
    self.stateImgView.contentMode=UIViewContentModeScaleAspectFit;
    
}

@end
