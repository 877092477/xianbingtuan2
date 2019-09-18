//
//  FNdisOddBuyheadMsgCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisOddBuyheadMsgCell.h"

@implementation FNdisOddBuyheadMsgCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews{
    
    
    self.headImg=[[UIImageView alloc]init];
    [self addSubview:self.headImg];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.phoneLB=[[UILabel alloc]init];
    [self addSubview:self.phoneLB];
    
    self.headImg.cornerRadius=50/2;
    
    self.nameLB.font=[UIFont systemFontOfSize:14];
    self.nameLB.textColor=RGB(102, 102, 102);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.phoneLB.font=[UIFont systemFontOfSize:11];
    self.phoneLB.textColor=RGB(102, 102, 102);
    self.phoneLB.textAlignment=NSTextAlignmentLeft;
    
    self.headImg.sd_layout
    .leftSpaceToView(self, 22).topSpaceToView(self, 15).widthIs(50).heightIs(50);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImg, 10).topSpaceToView(self, 20).rightSpaceToView(self, 10).heightIs(18);
    
    self.phoneLB.sd_layout
    .leftSpaceToView(self.headImg, 10).topSpaceToView(self.nameLB, 6).rightSpaceToView(self, 10).heightIs(18);
    
    UIView *line=[UIView new];
    line.backgroundColor=RGB(250, 250, 250);
    [self addSubview:line];
    line.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(12);
    
}
@end
