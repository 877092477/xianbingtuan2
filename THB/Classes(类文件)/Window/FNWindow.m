//
//  FNWindow.m
//  新版嗨如意
//
//  Created by Weller on 2019/5/23.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNWindow.h"
#import "FNErrorViewController.h"

@interface FNWindow()

@property (nonatomic, strong) FNErrorViewController *errorViewController;

@end

@implementation FNWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        _errorViewController = [[FNErrorViewController alloc] init];
    }
    return self;
}

- (void)showNetworkError {
    [self addSubview: _errorViewController.view];
}
- (void)dismissNetworkError {
    [_errorViewController.view removeFromSuperview];
}

- (void)reconnect {
    if ([[_errorViewController.view superview] isEqual: self]) {
        [_errorViewController reconnect];
    }
}

@end
