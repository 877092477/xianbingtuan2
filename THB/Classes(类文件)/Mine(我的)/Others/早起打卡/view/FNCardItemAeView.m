//
//  FNCardItemAeView.m
//  THB
//
//  Created by Jimmy on 2019/2/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCardItemAeView.h"

@implementation FNCardItemAeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}

-(void)setUpAllView{ 
    /** 背景img **/
    self.headImg=[[UIImageView alloc]init];
    self.headImg.image=IMAGE(@"");
    self.headImg.cornerRadius=58/2;
    [self addSubview:self.headImg];
    /** 描述img **/
    self.describeImg=[UIButton buttonWithType:UIButtonTypeCustom];
    self.describeImg.titleLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:self.describeImg];
    /** 名字 **/
    self.nameLB=[[UILabel alloc]init];
    self.nameLB.font=[UIFont systemFontOfSize:11];
    self.nameLB.textColor=RGB(24,24,24);
    self.nameLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.nameLB];
    /** 金额  **/
    self.sumLB=[[UILabel alloc]init];
    self.sumLB.font=[UIFont systemFontOfSize:13];
    self.sumLB.textColor=RGB(255,75,75);
    self.sumLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.sumLB];
    //.leftSpaceToView(self, inter_20).rightSpaceToView(self, inter_20).topSpaceToView(self, 120).heightIs(17);
    self.headImg.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, 37).heightIs(58).widthIs(58);
    
    self.describeImg.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, 77).heightIs(24).widthIs(75);
    
    self.sumLB.sd_layout
    .leftSpaceToView(self, 5).rightSpaceToView(self, 5).topSpaceToView(self, 130).heightIs(15);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 5).rightSpaceToView(self, 5).topSpaceToView(self, 108).heightIs(15);
    
}
@end
