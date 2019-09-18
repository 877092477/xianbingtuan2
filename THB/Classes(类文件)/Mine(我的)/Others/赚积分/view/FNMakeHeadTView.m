//
//  FNMakeHeadTView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMakeHeadTView.h"

@implementation FNMakeHeadTView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.titleLB=[[UILabel alloc]init];
    self.centreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftline=[[UIView alloc]init];
    self.rightline=[[UIView alloc]init];
    [self addSubview:self.titleLB];
    [self addSubview:self.centreBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.leftline];
    [self addSubview:self.rightline];
    
    self.listView=[[FNmakeHeadListView alloc]initWithFrame:CGRectMake(0, 155, FNDeviceWidth, 60)];
    [self addSubview:self.listView];
    
    self.titleLB.sd_layout
    .bottomSpaceToView(self, 6).widthIs(190).centerXEqualToView(self).heightIs(20);
    self.leftline.sd_layout
    .centerYEqualToView(self.titleLB).heightIs(1).widthIs(50).rightSpaceToView(self.titleLB, 10);
    self.rightline.sd_layout
    .centerYEqualToView(self.titleLB).heightIs(1).widthIs(50).leftSpaceToView(self.titleLB, 10);
    
    self.centreBtn.sd_layout
    .centerXEqualToView(self).widthIs(78).heightIs(78).topSpaceToView(self, SafeAreaTopHeight+5);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 0).widthIs(65).heightIs(20).topSpaceToView(self, SafeAreaTopHeight+10);
    
    self.listView.sd_layout
    .bottomSpaceToView(self.titleLB, 5).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(60);
    
    self.titleLB.font=kFONT12;
    self.titleLB.textColor=[UIColor whiteColor];
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    //self.rightBtn.backgroundColor=RGBA(255, 255, 255, 0.3);
    
    self.centreBtn.titleLabel.font=kFONT14;
    self.rightBtn.titleLabel.font=kFONT12;
    
//    self.titleLB.text=@"100积分=1元，可抵现金，可换商品";
//    [self.centreBtn setTitle:@"去兑换" forState:UIControlStateNormal];
//    [self.rightBtn setTitle:@"积分说明" forState:UIControlStateNormal];
    
//    [self.rightBtn sd_setBackgroundImageWithURL:URL(@"http://192.168.0.125/fnuoos_v1/Upload/task/1554175659_1_4.png") forState:UIControlStateNormal];
//    [self.centreBtn sd_setBackgroundImageWithURL:URL(@"http://192.168.0.125/fnuoos_v1/Upload/task/1554175659_1_1.png") forState:UIControlStateNormal];
}
-(void)setModel:(FNMakeTmodel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.task_s_title;
        self.titleLB.textColor=[UIColor colorWithHexString:model.task_font_color];
        [self.centreBtn setTitleColor:[UIColor colorWithHexString:model.task_btn_clolr] forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor colorWithHexString:model.task_jf_clolr] forState:UIControlStateNormal];
        [self.centreBtn setTitle:model.task_btn_content forState:UIControlStateNormal];
        [self.rightBtn setTitle:model.task_jf_btn_words forState:UIControlStateNormal];
        [self.rightBtn sd_setBackgroundImageWithURL:URL(model.task_jf_btn_bg) forState:UIControlStateNormal];
        [self.centreBtn sd_setBackgroundImageWithURL:URL(model.task_btnbg) forState:UIControlStateNormal]; 
        self.listView.dataArr=model.jf_and_yj;//jf
        self.listView.textColor=model.task_font_color;
        self.leftline.backgroundColor=[UIColor whiteColor];
        self.rightline.backgroundColor=[UIColor whiteColor];
         
    }
}
@end
