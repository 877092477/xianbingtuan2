//
//  FNcandiesTaskSternView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesTaskSternView.h"

@implementation FNcandiesTaskSternView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.bgImgView=[[UIImageView alloc]init];
    self.centreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [self addSubview:self.bgImgView];
    
    [self addSubview:self.centreBtn];
    self.centreBtn.titleLabel.font=kFONT10;
    [self.centreBtn setTitleColor:RGB(160, 160, 160) forState:UIControlStateNormal];
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 4).rightSpaceToView(self, 4).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.centreBtn.sd_layout
    .centerXEqualToView(self).heightIs(13).widthIs(100).topEqualToView(self);
    //self.centreBtn.imageView.sd_layout
    //.centerYEqualToView(self.centreBtn).rightSpaceToView(self.centreBtn, 0).widthIs(9).heightIs(5);
    //self.centreBtn.titleLabel.sd_layout
    //.leftSpaceToView(self.centreBtn, 0).rightSpaceToView(self.centreBtn, 11).heightIs(13).centerXEqualToView(self.centreBtn);
    self.centreBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    //self.bgImgView.contentMode = UIViewContentModeScaleAspectFill;
}
-(void)setModel:(FNCandiesTaskStyleModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setUrlImg:model.bottom_bj];
        if([model.type isEqualToString:@"my"]){
            [self.centreBtn setTitle:@"" forState:UIControlStateNormal];
        }
    }
}
@end
