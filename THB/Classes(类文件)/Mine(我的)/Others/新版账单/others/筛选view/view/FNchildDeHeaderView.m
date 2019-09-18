//
//  FNchildDeHeaderView.m
//  THB
//
//  Created by Jimmy on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNchildDeHeaderView.h"

@implementation FNchildDeHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.titleLB=[UILabel new];
    self.titleLB.textColor=RGB(140,140,140);
    self.titleLB.font=kFONT12;
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.titleLB];
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).heightIs(15).centerYEqualToView(self);
    [self.titleLB setSingleLineAutoResizeWithMaxWidth:280];
    
    //self.titleLB.text=@"收支类型";
}
@end
