//
//  FNArticleHeaderNEWView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArticleHeaderNEWView.h"

@implementation FNArticleHeaderNEWView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    self.titleLB.font=[UIFont systemFontOfSize:18];
    self.titleLB.textColor=RGB(51,51,51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).rightSpaceToView(self, 15).centerYEqualToView(self).heightIs(25);
    
}
@end
