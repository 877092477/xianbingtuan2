//
//  FNwelfTextNeReusableView.m
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//头部文字图片
#import "FNwelfTextNeReusableView.h"

@implementation FNwelfTextNeReusableView
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.backgroundColor=RGB(245, 245, 245);
    self.advertisingView=[UIImageView new];
    [self addSubview:self.advertisingView];
    
    self.rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.rightButton setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    [self.rightButton setTitle:@"规则详情" forState:UIControlStateNormal];
    [self.rightButton setBackgroundImage:IMAGE(@"FN_red_orthogon") forState:UIControlStateNormal];
    self.rightButton.titleLabel.font=kFONT10;
    self.rightButton.size=CGSizeMake(65, 15);
    [self addSubview:self.rightButton];
    self.rightButton.hidden=YES;
    
    self.advertisingView.sd_layout
    .leftSpaceToView(self, 20).heightIs(15).centerYEqualToView(self).widthIs(60);
    
    self.rightButton.sd_layout
    .heightIs(20).centerYEqualToView(self).widthIs(60).rightSpaceToView(self, 10);
}
-(void)setModel:(FNwelfDeModel *)model{
    _model = model;
    if (model) {
        [self.advertisingView setUrlImg:model.str_img];
    }
}
@end
