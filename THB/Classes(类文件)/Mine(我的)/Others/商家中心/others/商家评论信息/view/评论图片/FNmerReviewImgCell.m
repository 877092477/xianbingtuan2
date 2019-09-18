//
//  FNmerReviewImgCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/10.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerReviewImgCell.h"

@implementation FNmerReviewImgCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.ImgView=[[UIImageView alloc]init];
    [self addSubview:self.ImgView];
    self.ImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
}
@end
