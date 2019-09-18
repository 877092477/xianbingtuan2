//
//  FNhandConditionSternView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNhandConditionSternView.h"

@implementation FNhandConditionSternView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.askBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.askBtn];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.hintLB.font=[UIFont systemFontOfSize:10];
    self.hintLB.textColor=RGB(255, 236, 188);
    self.hintLB.textAlignment=NSTextAlignmentCenter;
    
    self.askBtn.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 20).heightIs(46);
    self.askBtn.imageView.sd_layout
    .leftSpaceToView(self.askBtn, 30).rightSpaceToView(self.askBtn, 30).centerYEqualToView(self.askBtn).heightIs(46);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 30).topSpaceToView(self.askBtn, 12).rightSpaceToView(self, 30).heightIs(14);
    
    self.askBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.askBtn.imageView.clipsToBounds = YES;
}
@end
