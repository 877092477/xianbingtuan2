//
//  FNconSeekGoodsSternView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNconSeekGoodsSternView.h"

@implementation FNconSeekGoodsSternView
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self initSubviewsUI];
    }
    return self;
}
-(void)initSubviewsUI{
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.lineView=[[UIView alloc]init];
    [self.bgView addSubview:self.lineView];
    
    self.matterBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.matterBtn];
    
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.lineView.backgroundColor=RGB(250, 250, 250);
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 0).rightSpaceToView(self, 10).bottomSpaceToView(self, 0);
    
    self.lineView.sd_layout
    .leftSpaceToView(self.bgView, 10).rightSpaceToView(self.bgView, 10).topSpaceToView(self.bgView, 0).heightIs(1);
    
    self.matterBtn.sd_layout
    .leftSpaceToView(self.bgView, 10).rightSpaceToView(self.bgView, 10).topSpaceToView(self.bgView, 10).bottomSpaceToView(self.bgView, 10);
    self.matterBtn.titleLabel.sd_layout
    .leftSpaceToView(self.matterBtn, 0).rightSpaceToView(self.matterBtn, 0).topSpaceToView(self.matterBtn, 0).bottomSpaceToView(self.matterBtn, 0);
    self.matterBtn.cornerRadius=5;
    self.matterBtn.titleLabel.font=kFONT16;
}
-(void)setModel:(FNmerConsumeModel *)model{
    _model=model;
    if(model){
        if([model.type isEqualToString:@"twoStyle"]){
            self.matterBtn.backgroundColor=[UIColor whiteColor];
            self.matterBtn.titleLabel.textAlignment=NSTextAlignmentRight;
            [self.matterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.matterBtn setTitle:model.shifu forState:UIControlStateNormal];
            
            self.bgView.sd_resetLayout
            .leftSpaceToView(self, 10).topSpaceToView(self, 0).rightSpaceToView(self, 10).bottomSpaceToView(self, 10);
            self.lineView.sd_resetLayout
            .leftSpaceToView(self.bgView, 10).rightSpaceToView(self.bgView, 10).topSpaceToView(self.bgView, 0).heightIs(1);
            self.matterBtn.sd_resetLayout
            .leftSpaceToView(self.bgView, 10).rightSpaceToView(self.bgView, 10).topSpaceToView(self.bgView, 10).bottomSpaceToView(self.bgView, 10);
            self.matterBtn.titleLabel.sd_resetLayout
            .leftSpaceToView(self.matterBtn, 0).rightSpaceToView(self.matterBtn, 0).topSpaceToView(self.matterBtn, 0).bottomSpaceToView(self.matterBtn, 0);
        }
        else if([model.type isEqualToString:@"msgStyle"]){
            self.matterBtn.backgroundColor=RGB(255, 104, 106);
            self.matterBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
            [self.matterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.matterBtn setTitle:@"确认此订单" forState:UIControlStateNormal];
            self.bgView.sd_resetLayout
            .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
            self.lineView.sd_resetLayout
            .leftSpaceToView(self.bgView, 0).rightSpaceToView(self.bgView, 0).topSpaceToView(self.bgView, 0).heightIs(10);
            self.matterBtn.sd_resetLayout
            .leftSpaceToView(self.bgView, 20).rightSpaceToView(self.bgView, 20).topSpaceToView(self.bgView, 25).bottomSpaceToView(self.bgView, 20);
            self.matterBtn.titleLabel.sd_resetLayout
            .leftSpaceToView(self.matterBtn, 0).rightSpaceToView(self.matterBtn, 0).topSpaceToView(self.matterBtn, 0).bottomSpaceToView(self.matterBtn, 0);
        }
    }
}
@end
