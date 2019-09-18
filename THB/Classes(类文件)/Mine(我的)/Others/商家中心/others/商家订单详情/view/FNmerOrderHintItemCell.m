//
//  FNmerOrderHintItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerOrderHintItemCell.h"

@implementation FNmerOrderHintItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.topBgView=[[UIView alloc]init];
    [self addSubview:self.topBgView];
    
    self.toplineView=[[UIView alloc]init];
    [self.topBgView addSubview:self.toplineView];
    
    self.bottomBgView=[[UIView alloc]init];
    [self addSubview:self.bottomBgView];
    
    self.sumLB=[[UILabel alloc]init];
    [self.topBgView addSubview:self.sumLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self.bottomBgView addSubview:self.hintLB];
    
    self.contactBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.topBgView addSubview:self.contactBtn];
    
    [self.contactBtn setTitleColor:RGB(47, 140, 255) forState:UIControlStateNormal];
    self.contactBtn.titleLabel.font=kFONT13;
    
    self.topBgView.backgroundColor=[UIColor whiteColor];
    self.bottomBgView.backgroundColor=[UIColor whiteColor];
    self.toplineView.backgroundColor=RGB(246, 245, 245);
    
    self.sumLB.font=[UIFont systemFontOfSize:13];
    self.sumLB.textColor=RGB(24, 24, 24);
    self.sumLB.textAlignment=NSTextAlignmentRight;
    
    self.hintLB.font=[UIFont systemFontOfSize:16];
    self.hintLB.textColor=RGB(60, 60, 60);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.topBgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 0).rightSpaceToView(self, 10).heightIs(50);
    
    self.toplineView.sd_layout
    .leftSpaceToView(self.topBgView, 10).topSpaceToView(self.topBgView, 0).rightSpaceToView(self.topBgView, 10).heightIs(1);
    
    self.bottomBgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self.topBgView, 10).rightSpaceToView(self, 10).heightIs(50);
    
    self.sumLB.sd_layout
    .rightSpaceToView(self.topBgView, 10).centerYEqualToView(self.topBgView).widthIs(140).heightIs(20);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self.bottomBgView, 10).centerYEqualToView(self.bottomBgView).widthIs(150).heightIs(20);
    
    self.contactBtn.sd_layout
    .leftSpaceToView(self.topBgView, 0).heightIs(25).centerYEqualToView(self.topBgView).widthIs(90);
    self.contactBtn.imageView.sd_layout
    .leftSpaceToView(self.contactBtn, 10).centerYEqualToView(self.contactBtn).widthIs(15).heightIs(15);
    self.contactBtn.titleLabel.sd_layout
    .leftSpaceToView(self.contactBtn, 30).centerYEqualToView(self.contactBtn).rightSpaceToView(self.contactBtn, 0).heightIs(20);
    self.contactBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    
    self.contactBtn.hidden = YES;
}

-(void)setModel:(FNmerOrderZModel *)model{
    _model=model;
    if(model){
        FNmerOrderZZHModel *centerModel=[FNmerOrderZZHModel mj_objectWithKeyValues:model.center];
        [self.contactBtn setImage:IMAGE(@"pay_photo") forState:UIControlStateNormal];
        [self.contactBtn setTitle:@"联系商家" forState:UIControlStateNormal];
        self.sumLB.text=[NSString stringWithFormat:@"实际支付  %@",centerModel.user_pay];
        self.hintLB.text=@"订单信息";
    }
}
@end
