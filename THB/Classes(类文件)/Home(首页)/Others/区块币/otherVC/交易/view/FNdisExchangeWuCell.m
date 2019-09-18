//
//  FNdisExchangeWuCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisExchangeWuCell.h"

@implementation FNdisExchangeWuCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews{ 
    
    self.stateLB=[[UILabel alloc]init];
    [self addSubview:self.stateLB];
    
    self.stateImg=[[UIImageView alloc]init];
    [self addSubview:self.stateImg];
    
    self.stateLB.font=[UIFont systemFontOfSize:15];
    self.stateLB.textColor=RGB(205, 205, 205);
    self.stateLB.textAlignment=NSTextAlignmentCenter;
    
    self.stateImg.sd_layout
    .topSpaceToView(self, 112).centerXEqualToView(self).widthIs(165).heightIs(130);
    
    self.stateLB.sd_layout
    .topSpaceToView(self.stateImg, 28).leftSpaceToView(self, 15).rightSpaceToView(self, 15).heightIs(20);
}
@end
