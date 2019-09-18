//
//  FNCommColummitHeaderView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCommColummitHeaderView.h"

@implementation FNCommColummitHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews{
    self.backgroundColor=RGB(250, 250, 250);
    self.bgImgView=[[UIImageView alloc]init];
    self.backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.bgImgView];
    [self addSubview:self.backBtn]; 
    //self.bgImgView.contentMode=UIViewContentModeScaleAspectFit;
    //self.bgImgView.clipsToBounds=YES;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(203);
    self.backBtn.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 27).heightIs(30).widthIs(50);
    self.backBtn.imageView.sd_layout
    .leftSpaceToView(self.backBtn, 17).heightIs(16).widthIs(8).centerYEqualToView(self.backBtn);
    [self.backBtn setImage:IMAGE(@"return_w") forState:UIControlStateNormal];
    //return_w  FN_ZCred_backImg
    
}
@end
