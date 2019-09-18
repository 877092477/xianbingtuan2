//
//  FNpredictTimeBaseView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNpredictTimeBaseView.h"

@implementation FNpredictTimeBaseView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews { 
    UIView *bgView=[[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor=[UIColor whiteColor];
    
    bgView.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self, 1).bottomSpaceToView(self, 0);
    
    self.addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.addBtn];
    self.addBtn.titleLabel.font=[UIFont systemFontOfSize:13]; 
    //[self.addBtn setImage:IMAGE(@"details_cion_add") forState:UIControlStateNormal];
    [self.addBtn setTitle:@" + 新增特殊时段" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    self.addBtn.sd_layout
    .centerXEqualToView(self).centerYEqualToView(self).heightIs(28).widthIs(100);
    [self.addBtn.titleLabel fn_changeColorWithTextColor:RGB(252, 119, 0) changeText:@"+"];
//    self.addBtn.imageView.sd_layout
//    .leftSpaceToView(self.addBtn, 0).widthIs(10).heightIs(10).centerYEqualToView(self.addBtn);
//    self.addBtn.titleLabel.sd_layout
//    .leftSpaceToView(self.addBtn, 15).rightSpaceToView(self.addBtn, 0).heightIs(16).centerYEqualToView(self.addBtn);
}
@end
