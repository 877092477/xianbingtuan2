//
//  FNmerPhotoSceneheadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerPhotoSceneheadView.h"

@implementation FNmerPhotoSceneheadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {  
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.editBtnView = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:self.editBtnView];
    
    self.editBtnView.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.editBtnView.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.editBtnView setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 40).rightSpaceToView(self, 88).heightIs(20).centerYEqualToView(self);
    
    self.editBtnView.sd_layout
    .rightSpaceToView(self, 15).centerYEqualToView(self).widthIs(70).heightIs(16);
    self.editBtnView.imageView.sd_layout
    .leftSpaceToView(self.editBtnView, 0).centerYEqualToView(self.editBtnView).widthIs(12).heightIs(12);
    self.editBtnView.titleLabel.sd_layout
    .leftSpaceToView(self.editBtnView.imageView, 5).centerYEqualToView(self.editBtnView).heightIs(16).rightSpaceToView(self.editBtnView, 0); 
    
    self.titleLB.text=@"门店内景(3)";
    [self.editBtnView setTitle:@"编辑标签" forState:UIControlStateNormal];
    [self.editBtnView setImage:IMAGE(@"pay_icon_amend") forState:UIControlStateNormal];
}
@end
