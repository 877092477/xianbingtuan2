//
//  FNtallyPhotoTextItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNtallyPhotoTextItemCell.h"

@implementation FNtallyPhotoTextItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.titleLb=[[UILabel alloc]init];
    [self addSubview:self.titleLb];
    self.titleLb.font=[UIFont systemFontOfSize:11];
    self.titleLb.textColor=RGB(255, 120, 0);
    self.titleLb.textAlignment=NSTextAlignmentCenter;  
    self.titleLb.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
}
@end
