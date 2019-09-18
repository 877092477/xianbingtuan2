//
//  FNarticleImgHeaderXView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNarticleImgHeaderXView.h"

@implementation FNarticleImgHeaderXView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews{
    self.backgroundColor=RGB(250, 250, 250);
    self.topImgView=[[UIImageView alloc]init];
    [self addSubview:self.topImgView];
    self.topImgView.contentMode=UIViewContentModeCenter;
    self.topImgView.clipsToBounds=YES;
    //self.topImgView.sd_layout
    //.centerXEqualToView(self).centerYEqualToView(self)
    //.heightIs(20).widthIs(150);
    
    self.topImgView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).centerYEqualToView(self).heightIs(30);
}
@end
