//
//  FNrelationUeHeader.m
//  THB
//
//  Created by 李显 on 2019/1/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNrelationUeHeader.h"

@implementation FNrelationUeHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
    
    self.nameLB=[UILabel new];
    self.nameLB.font=kFONT11;
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.nameLB];
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 15).centerYEqualToView(self).heightIs(15);
    [self.nameLB setSingleLineAutoResizeWithMaxWidth:150];
    
    self.nameLB.text=@"最近聊天";
}


@end
