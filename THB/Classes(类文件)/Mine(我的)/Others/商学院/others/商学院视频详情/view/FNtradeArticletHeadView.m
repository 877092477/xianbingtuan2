//
//  FNtradeArticletHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNtradeArticletHeadView.h"

@implementation FNtradeArticletHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews{
    
    self.typeImgView=[[UIImageView alloc]init];
    [self addSubview:self.typeImgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.countLB=[[UILabel alloc]init];
    [self addSubview:self.countLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.hotImgView=[[UIImageView alloc]init];
    [self addSubview:self.hotImgView];
    
    self.hintLB.font=[UIFont systemFontOfSize:12];
    self.hintLB.textColor=RGB(182, 183, 184);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(27, 28, 36);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    self.titleLB.numberOfLines=2;
    
    self.countLB.font=[UIFont systemFontOfSize:9];
    self.countLB.textColor=RGB(27, 28, 36);
    self.countLB.textAlignment=NSTextAlignmentLeft;
    
    self.typeImgView.sd_layout
    .leftSpaceToView(self, 12).topSpaceToView(self, 14).widthIs(18).heightIs(17);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.typeImgView, 5).rightSpaceToView(self, 10).heightIs(46).topSpaceToView(self, 13);
    
    self.countLB.sd_layout
    .rightSpaceToView(self, 10).bottomSpaceToView(self, 30).heightIs(13).widthIs(30);
    
    self.hotImgView.sd_layout
    .rightSpaceToView(self.countLB, 5).centerYEqualToView(self.countLB).widthIs(10).heightIs(11);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 12).rightSpaceToView(self.hotImgView, 10).centerYEqualToView(self.countLB).heightIs(16);
    
    self.hintLB.text=@"原创：嗨如意商学院  3天前";
    self.titleLB.text=@"嗨如意商学院新人必看小技巧《让你微信被加爆的方法》";
    self.countLB.text=@"1.5w";
    
    CGFloat countLBW=[self.countLB.text kr_getWidthWithTextHeight:13 font:9];
    if(countLBW>80){
       countLBW=80;
    }
    self.countLB.sd_layout
    .rightSpaceToView(self, 10).bottomSpaceToView(self, 30).heightIs(13).widthIs(countLBW);
    
    self.hotImgView.sd_layout
    .rightSpaceToView(self.countLB, 5).centerYEqualToView(self.countLB).widthIs(10).heightIs(11);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 12).rightSpaceToView(self.hotImgView, 10).centerYEqualToView(self.countLB).heightIs(16);
}
@end
