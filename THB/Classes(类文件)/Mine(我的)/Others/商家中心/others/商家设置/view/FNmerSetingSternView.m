//
//  FNmerSetingSternView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerSetingSternView.h"

@implementation FNmerSetingSternView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.alterbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.alterbtn.frame=CGRectMake(20, 20, FNDeviceWidth-40, 50);
    [self.alterbtn setTitle:@"修改申请" forState:UIControlStateNormal];
    [self.alterbtn setBackgroundColor:RGB(244, 32, 40)];
    self.alterbtn.titleLabel.font=kFONT16;
    self.alterbtn.cornerRadius=5;
    [self addSubview:self.alterbtn];
}
@end
