//
//  FNdistrictPeopleMsgCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdistrictPeopleMsgCell.h"

@implementation FNdistrictPeopleMsgCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    self.phoneNumLB=[[UILabel alloc]init];
    [self addSubview:self.phoneNumLB];
    self.headImg=[[UIImageView alloc]init];
    [self addSubview:self.headImg];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.lineView.backgroundColor=RGB(240,240,240);
    
    self.nameLB.font=[UIFont systemFontOfSize:15];
    self.nameLB.textColor=RGB(153, 153, 153);
    self.nameLB.textAlignment=NSTextAlignmentCenter;
    
    self.phoneNumLB.font=[UIFont systemFontOfSize:15];
    self.phoneNumLB.textColor=RGB(153, 153, 153);
    self.phoneNumLB.textAlignment=NSTextAlignmentCenter;
    
    self.headImg.sd_layout
    .widthIs(50).heightIs(50).centerXEqualToView(self).topSpaceToView(self, 15);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self.headImg, 7).rightSpaceToView(self, 15).heightIs(20);
    
    self.phoneNumLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self.nameLB, 2).rightSpaceToView(self, 15).heightIs(20);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(1);
}
@end
