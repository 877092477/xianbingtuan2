//
//  FNtradeLeftTextHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNtradeLeftTextHeadView.h"

@implementation FNtradeLeftTextHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews{
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    self.imgView.contentMode=UIViewContentModeCenter;
    self.imgView.clipsToBounds=YES;
    self.imgView.sd_layout
    .leftSpaceToView(self, 12).centerYEqualToView(self).heightIs(20).widthIs(3);
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=RGB(23, 22, 26);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.imgView, 10).centerYEqualToView(self).rightSpaceToView(self, 15).heightIs(20);
}
@end
