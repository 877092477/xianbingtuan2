//
//  FNTradeImgHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNTradeImgHeadView.h"

@implementation FNTradeImgHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews{
    self.titleImgView=[[UIImageView alloc]init];
    [self addSubview:self.titleImgView]; 
    self.titleImgView.contentMode=UIViewContentModeCenter;
    self.titleImgView.clipsToBounds=YES;
    self.titleImgView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).centerYEqualToView(self).heightIs(40);
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    self.lineView.backgroundColor=RGB(240, 240, 240);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 12).bottomEqualToView(self).rightSpaceToView(self, 12).heightIs(1);
}
@end
