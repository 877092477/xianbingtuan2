//
//  CireleImageLeftBtn.m
//  THB
//
//  Created by 李显 on 2018/8/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "CireleImageLeftBtn.h"

@implementation CireleImageLeftBtn

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imgW = CGRectGetWidth(self.imageView.bounds);
    
    CGSize size = [self getSize];
    self.imageView.frame = CGRectMake(0, 0, 15, 15);
    self.titleLabel.frame = CGRectMake(imgW + 2, 0, size.width, size.height);
    if(size.width>80){
        self.titleLabel.frame = CGRectMake(imgW + 2, 0, 80, size.height);
    }
    
}
- (CGSize)getSize
{
    return [self.titleLabel.text boundingRectWithSize:CGSizeMake(FNDeviceWidth, FNDeviceHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
