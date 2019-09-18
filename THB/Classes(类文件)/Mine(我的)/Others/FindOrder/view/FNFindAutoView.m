//
//  FNFindAutoView.m
//  SuperMode
//
//  Created by jimmy on 2017/8/3.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNFindAutoView.h"

@implementation FNFindAutoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"FNFindAutoView" owner:nil options:nil] lastObject];
    }
    return self;
}

@end
