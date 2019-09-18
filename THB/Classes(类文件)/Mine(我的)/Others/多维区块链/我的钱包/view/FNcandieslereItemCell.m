//
//  FNcandieslereItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandieslereItemCell.h"

@implementation FNcandieslereItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:10];
    self.hintLB.textColor=RGB(197, 196, 202);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 8).centerYEqualToView(self).widthIs(56).heightIs(56);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.imgView, 12).topSpaceToView(self, 15).heightIs(19).rightSpaceToView(self, 5);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self.imgView, 12).topSpaceToView(self.titleLB, 2).heightIs(14).rightSpaceToView(self, 5);
    
    self.imgView.cornerRadius=5/2;
    self.imgView.backgroundColor=[UIColor whiteColor];
    
    //self.titleLB.text=@"转让糖果";
    //self.hintLB.text=@"(不可转让到余额)";
    //self.bgImgView.contentMode=UIViewContentModeScaleAspectFill; 
    
}

-(void)setModel:(FNCandiesMyoperationItemModel *)model{
    _model=model;
    if(model){
        [self.imgView setUrlImg:model.icon];
        self.titleLB.text=model.str;
        self.hintLB.text=model.tips;
    }
}
-(void)setBgImg:(NSString *)bgImg{
    _bgImg=bgImg;
    if(bgImg){
        [self.bgImgView setUrlImg:bgImg];
        
    }
}
@end
