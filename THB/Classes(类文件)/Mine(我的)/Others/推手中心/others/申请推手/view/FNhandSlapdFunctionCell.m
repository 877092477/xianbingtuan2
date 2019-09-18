//
//  FNhandSlapdFunctionCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNhandSlapdFunctionCell.h"

@implementation FNhandSlapdFunctionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.contentImgView=[[UIImageView alloc]init];
    [self addSubview:self.contentImgView];
    CGFloat top_gap=20;
    self.contentImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, top_gap).rightSpaceToView(self, 0).bottomSpaceToView(self, 10);
    
    self.contentImgView.clipsToBounds = YES;
    self.contentImgView.contentMode=UIViewContentModeScaleAspectFit;
    
}

 
@end
