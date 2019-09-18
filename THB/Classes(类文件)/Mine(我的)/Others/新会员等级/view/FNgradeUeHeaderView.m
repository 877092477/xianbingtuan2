//
//  FNgradeUeHeaderView.m
//  THB
//
//  Created by 李显 on 2019/1/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNgradeUeHeaderView.h"

@implementation FNgradeUeHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.dateLB=[UILabel new];
    self.dateLB.textColor=RGB(153,153,153);
    self.dateLB.font=kFONT12;
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.dateLB];
    
    self.dateLB.sd_layout
    .topSpaceToView(self, 15).leftSpaceToView(self, 30).heightIs(15).widthIs(130);
    
    
    
}
@end
