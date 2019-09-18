//
//  FNcandiesGradeHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesGradeHeadView.h"

@implementation FNcandiesGradeHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    self.detailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.detailBtn];
    
    self.lineView.backgroundColor=RGB(220, 193, 50);
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(27, 27, 27);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.detailBtn.titleLabel.font=kFONT12;
    [self.detailBtn setTitleColor:RGB(104, 104, 108) forState:UIControlStateNormal];
    
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 20).centerYEqualToView(self).widthIs(4).heightIs(15);
    self.titleLB.sd_layout
    .leftSpaceToView(self.lineView, 15).centerYEqualToView(self).widthIs(100).heightIs(20);
    
    self.detailBtn.sd_layout
    .rightSpaceToView(self, 15).centerYEqualToView(self).widthIs(85).heightIs(20);
//    self.detailBtn.imageView.sd_layout
//    .widthIs(6).heightIs(12).centerYEqualToView(self.detailBtn).rightSpaceToView(self.detailBtn, 0);
    self.detailBtn.titleLabel.sd_layout
    .rightSpaceToView(self.detailBtn, 0).centerYEqualToView(self.detailBtn).heightIs(16).leftSpaceToView(self.detailBtn, 0);
    self.detailBtn.titleLabel.textAlignment=NSTextAlignmentRight;  
    //self.titleLB.text=@"等级说明";
    //[self.detailBtn setTitle:@"成长值明细" forState:UIControlStateNormal];
    //[self.detailBtn setImage:IMAGE(@"FJ_minRight_img") forState:UIControlStateNormal];
}
@end
