//
//  FNcandiesTaskHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesTaskHeadView.h"

@implementation FNcandiesTaskHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{  
    self.baskBgImgView=[[UIImageView alloc]init];
    self.taskTitleLB=[[UILabel alloc]init];
    [self addSubview:self.baskBgImgView];
    [self addSubview:self.taskTitleLB];
    self.taskTitleLB.font=kFONT15;
    self.taskTitleLB.textColor=[UIColor whiteColor];
    self.taskTitleLB.textAlignment=NSTextAlignmentCenter;
    self.baskBgImgView.sd_layout
    .leftSpaceToView(self, 5).rightSpaceToView(self, 5).topSpaceToView(self, 10).bottomSpaceToView(self, 0);
    self.taskTitleLB.sd_layout
    .centerXEqualToView(self).widthIs(140).heightIs(48).bottomSpaceToView(self, 0);
    //self.baskBgImgView.contentMode = UIViewContentModeScaleAspectFill;
}
-(void)setModel:(FNCandiesTaskStyleModel *)model{
    _model=model;
    if(model){
        [self.baskBgImgView setUrlImg:model.top_bj];
        self.taskTitleLB.text=model.title;
        self.taskTitleLB.textColor=[UIColor colorWithHexString:model.title_color];
    }
}
@end
