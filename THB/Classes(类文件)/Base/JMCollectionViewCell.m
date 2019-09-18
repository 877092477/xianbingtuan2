//
//  JMCollectionViewCell.m
//  SuperMode
//
//  Created by jimmy on 2017/6/8.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMCollectionViewCell.h"

@implementation JMCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self jm_setupViews];
    }
    return self;
}

- (void)jm_setupViews {}
@end
