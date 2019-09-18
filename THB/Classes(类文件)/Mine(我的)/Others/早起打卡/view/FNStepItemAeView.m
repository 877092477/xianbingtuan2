//
//  FNStepItemAeView.m
//  THB
//
//  Created by Jimmy on 2019/2/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNStepItemAeView.h"

@implementation FNStepItemAeView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}

-(void)setUpAllView{
    
    /** 描述img **/
    self.describeImg=[[UIImageView alloc]init];
    self.describeImg.image=IMAGE(@"");
    [self addSubview:self.describeImg];
    /** 名字 **/
    self.nameLB=[[UILabel alloc]init];
    self.nameLB.font=[UIFont systemFontOfSize:11];
    self.nameLB.textColor=RGB(24,24,24);
    self.nameLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.nameLB];
    
    self.describeImg.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, 20).heightIs(59).widthIs(76);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self.describeImg, 7).heightIs(15);
    
}
@end
