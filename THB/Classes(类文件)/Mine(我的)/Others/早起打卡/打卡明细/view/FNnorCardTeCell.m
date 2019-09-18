//
//  FNnorCardTeCell.m
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNnorCardTeCell.h"

@implementation FNnorCardTeCell
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
    [self addSubview:self.bgImg];
    
    self.titleLB=[[UILabel alloc]init];
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=RGB(245, 245, 245);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.titleLB];
    
    self.bgImg.image=IMAGE(@"FN_norCardimg");
    self.titleLB.text=@"暂无打卡记录哦";
    
    [self incomposition];
}

-(void)incomposition{
    CGFloat inter_5=5;
    
    self.bgImg.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, 75).heightIs(128).widthIs(75);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, inter_5).rightSpaceToView(self, inter_5).topSpaceToView(self.bgImg, 6).heightIs(17);
    
    
}

@end
