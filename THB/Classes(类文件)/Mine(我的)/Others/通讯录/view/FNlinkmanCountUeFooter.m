//
//  FNlinkmanCountUeFooter.m
//  THB
//
//  Created by 李显 on 2019/1/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNlinkmanCountUeFooter.h"

@implementation FNlinkmanCountUeFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.backgroundColor=RGB(242,242,242);
    
    self.contentLB=[UILabel new];
    self.contentLB.font=kFONT13;
    self.contentLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.contentLB];
    
    self.contentLB.sd_layout
    .leftSpaceToView(self, 15).rightSpaceToView(self, 15).centerYEqualToView(self).heightIs(17);
    
    
    self.contentLB.text=@"全部共9367位好友";
}


@end
