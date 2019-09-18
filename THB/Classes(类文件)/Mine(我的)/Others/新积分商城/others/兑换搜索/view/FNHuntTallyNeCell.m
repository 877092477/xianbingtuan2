//
//  FNHuntTallyNeCell.m
//  THB
//
//  Created by Jimmy on 2019/1/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNHuntTallyNeCell.h"

@implementation FNHuntTallyNeCell
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
    self.titleLB.font=kFONT12;
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    self.titleLB.textColor=RGB(60,60,60);
    self.titleLB.borderWidth=1;
    self.titleLB.borderColor=RGB(240,239,239);
    self.titleLB.cornerRadius=16;
    self.titleLB.clipsToBounds = YES;
    [self addSubview:self.titleLB];
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    //[self.titleLB setSingleLineAutoResizeWithMaxWidth:280];
    
    //self.titleLB.text=@"会员升级";
}
+ (CGSize) getSizeWithText:(NSString*)text;
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 32) options: NSStringDrawingUsesLineFragmentOrigin   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width+20, 32);
}

@end
