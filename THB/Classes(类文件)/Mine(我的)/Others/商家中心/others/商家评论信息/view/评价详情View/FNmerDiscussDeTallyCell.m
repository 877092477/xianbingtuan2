//
//  FNmerDiscussDeTallyCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/31.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDiscussDeTallyCell.h"

@implementation FNmerDiscussDeTallyCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:11];
    self.titleLB.textColor=RGB(242, 58, 77);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    self.titleLB.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    self.titleLB.cornerRadius=4;
    self.titleLB.borderWidth=1;
    self.titleLB.borderColor = RGB(242, 58, 77);
}
@end
