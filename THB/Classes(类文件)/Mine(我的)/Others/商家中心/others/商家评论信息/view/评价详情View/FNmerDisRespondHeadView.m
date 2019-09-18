//
//  FNmerDisRespondHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/31.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDisRespondHeadView.h"

@implementation FNmerDisRespondHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.nameLB.font=[UIFont systemFontOfSize:11];
    self.nameLB.textColor=RGB(24, 24, 24);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:10];
    self.dateLB.textColor=RGB(140, 140, 140);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 10).widthIs(13).heightIs(13).topSpaceToView(self, 13);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 34).rightSpaceToView(self, 115).centerYEqualToView(self.imgView).heightIs(16);
    
    self.dateLB.sd_layout
    .rightSpaceToView(self, 10).centerYEqualToView(self.imgView).widthIs(100).heightIs(12);
}
@end
