//
//  FNmeMemberIndentitCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeMemberIndentitCell.h"

@implementation FNmeMemberIndentitCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.sumLB=[[UILabel alloc]init];
    [self addSubview:self.sumLB];
    
    self.sumHintLB=[[UILabel alloc]init];
    [self addSubview:self.sumHintLB];
    
    self.timeLB=[[UILabel alloc]init];
    [self addSubview:self.timeLB];
    
    self.typeLB=[[UILabel alloc]init];
    [self addSubview:self.typeLB];
    
    self.stateLB=[[UILabel alloc]init];
    [self addSubview:self.stateLB];
    
    
    self.evaluateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.evaluateBtn];
    
    self.affirmBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.affirmBtn];
    
    self.nameLB.font=[UIFont systemFontOfSize:16];
    self.nameLB.textColor=RGB(24, 24, 24);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:10];
    self.hintLB.textColor=RGB(200, 200, 200);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.sumLB.font=[UIFont systemFontOfSize:12];
    self.sumLB.textColor=RGB(60, 60, 60);
    self.sumLB.textAlignment=NSTextAlignmentLeft;
    
    self.sumHintLB.font=[UIFont systemFontOfSize:11];
    self.sumHintLB.textColor=RGB(255, 93, 93);
    self.sumHintLB.textAlignment=NSTextAlignmentLeft;
    
    self.timeLB.font=[UIFont systemFontOfSize:11];
    self.timeLB.textColor=RGB(140, 140, 140);
    self.timeLB.textAlignment=NSTextAlignmentLeft;
    
    self.typeLB.font=[UIFont systemFontOfSize:11];
    self.typeLB.textColor=RGB(255, 93, 93);
    self.typeLB.textAlignment=NSTextAlignmentCenter;
    
    self.stateLB.font=[UIFont systemFontOfSize:12];
    self.stateLB.textColor=RGB(255, 155, 48);
    self.stateLB.textAlignment=NSTextAlignmentRight;
    
    self.imgView.cornerRadius=5;
    self.imgView.clipsToBounds=YES;
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 39).widthIs(90).heightIs(90);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.imgView, 15).topSpaceToView(self, 43).rightSpaceToView(self, 10).heightIs(20);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self.imgView, 15).topSpaceToView(self.nameLB, 5).rightSpaceToView(self, 10).heightIs(14);
    
    self.sumLB.sd_layout
    .leftSpaceToView(self.imgView, 15).topSpaceToView(self.hintLB, 9).rightSpaceToView(self, 10).heightIs(18);
    
//    self.sumHintLB.sd_layout
//    .leftSpaceToView(self.imgView, 15).topSpaceToView(self.sumLB, 1).widthIs(100).heightIs(15);
    [self.sumHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0);
        make.left.equalTo(self.imgView.mas_right).offset(15);
        make.top.equalTo(self.sumLB.mas_bottom).offset(1);
        make.height.mas_equalTo(15);
        make.right.lessThanOrEqualTo(self.stateLB.mas_left).offset(-4);
    }];
    
    self.timeLB.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 11).heightIs(15).rightSpaceToView(self, 90);
    
    self.typeLB.sd_layout
    .rightSpaceToView(self, 10).heightIs(18).centerYEqualToView(self.timeLB).widthIs(55);
    
    self.evaluateBtn.sd_layout
    .rightSpaceToView(self, 10).widthIs(65).heightIs(25).bottomEqualToView(self.imgView);
    
    self.affirmBtn.sd_layout
    .rightSpaceToView(self, 10).widthIs(65).heightIs(25).centerYEqualToView(self.imgView);
    
    self.stateLB.sd_layout
    .rightSpaceToView(self.evaluateBtn, 8).centerYEqualToView(self.evaluateBtn).heightIs(15).widthIs(45);
    
    
    [self.evaluateBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    self.evaluateBtn.titleLabel.font=kFONT12;
    
    [self.affirmBtn setTitleColor:RGB(255, 99, 101) forState:UIControlStateNormal];
    self.affirmBtn.titleLabel.font=kFONT12;
    
    self.typeLB.cornerRadius=18/2;
    self.typeLB.borderWidth=1;
    self.typeLB.borderColor = RGB(255, 58, 81);
    self.typeLB.clipsToBounds = YES;
    
}

-(void)setModel:(FNmeMemberIndentItemModel *)model{
    _model=model;
    if(model){
        NSString *datestr=[NSString getTimeStr:model.createDate];
        self.timeLB.text=[NSString stringWithFormat:@"下单时间: %@",datestr];
        self.typeLB.text=model.type;
        self.nameLB.text=model.store_name;
        self.hintLB.text=[NSString stringWithFormat:@"%@ %@",model.store_name,model.content];
        
        if([model.payment kr_isNotEmpty]){
           self.sumLB.text=[NSString stringWithFormat:@"¥%@",model.payment];
           [self.sumLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:18] changeText:model.payment];
        }
        self.sumHintLB.text=model.str;
        self.stateLB.text=model.status;
       
        [self.imgView setUrlImg:model.img];
        
        self.typeLB.textColor=[UIColor colorWithHexString:model.type_color];
        self.typeLB.borderColor = [UIColor colorWithHexString:model.type_color];
        self.stateLB.textColor=[UIColor colorWithHexString:model.color];
        
        NSInteger apply_refund=[model.apply_refund integerValue];
        NSInteger has_comment=[model.has_comment integerValue];
        
        if(apply_refund==0){
            self.evaluateBtn.hidden=YES;
            [self.evaluateBtn setTitle:@"" forState:UIControlStateNormal];
            self.evaluateBtn.sd_resetLayout
            .rightSpaceToView(self, 10).widthIs(0).heightIs(25).bottomEqualToView(self.imgView);
            
            self.stateLB.sd_resetLayout
            .rightSpaceToView(self.evaluateBtn, 8).centerYEqualToView(self.evaluateBtn).heightIs(15).widthIs(45);
        }
        if(apply_refund==1){
            self.evaluateBtn.hidden=NO;
           [self.evaluateBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            self.evaluateBtn.sd_resetLayout
            .rightSpaceToView(self, 10).widthIs(65).heightIs(25).bottomEqualToView(self.imgView);
            
            self.stateLB.sd_resetLayout
            .rightSpaceToView(self.evaluateBtn, 8).centerYEqualToView(self.evaluateBtn).heightIs(15).widthIs(45);
            [self.evaluateBtn addTarget:self action:@selector(cancelIndentitAction)];
        }
        if(apply_refund==2){
            self.evaluateBtn.hidden=NO;
           [self.evaluateBtn setTitle:@"取消申请" forState:UIControlStateNormal];
            self.evaluateBtn.sd_resetLayout
            .rightSpaceToView(self, 10).widthIs(65).heightIs(25).bottomEqualToView(self.imgView);
            
            self.stateLB.sd_resetLayout
            .rightSpaceToView(self.evaluateBtn, 8).centerYEqualToView(self.evaluateBtn).heightIs(15).widthIs(45);
            [self.evaluateBtn addTarget:self action:@selector(cancelRefundAction)];
        }
        if(has_comment==1){
            self.evaluateBtn.hidden=NO;
            [self.evaluateBtn setTitle:@"评价" forState:UIControlStateNormal];
            self.evaluateBtn.sd_resetLayout
            .rightSpaceToView(self, 10).widthIs(65).heightIs(25).bottomEqualToView(self.imgView);
            
            self.stateLB.sd_resetLayout
            .rightSpaceToView(self.evaluateBtn, 8).centerYEqualToView(self.evaluateBtn).heightIs(15).widthIs(45);
            [self.evaluateBtn addTarget:self action:@selector(evaluateAction)];
        }
        if([model.status containsString:@"失效"]){
            self.evaluateBtn.hidden=YES;
            [self.evaluateBtn setTitle:@"" forState:UIControlStateNormal];
            self.evaluateBtn.sd_resetLayout
            .rightSpaceToView(self, 10).widthIs(0).heightIs(25).bottomEqualToView(self.imgView);
            
            self.stateLB.sd_resetLayout
            .rightSpaceToView(self.evaluateBtn, 8).centerYEqualToView(self.evaluateBtn).heightIs(15).widthIs(45);
        }
        
        self.evaluateBtn.cornerRadius=25/2;
        self.evaluateBtn.borderWidth=1;
        self.evaluateBtn.borderColor = RGB(233, 233, 233);
        self.evaluateBtn.clipsToBounds = YES;
        
         NSInteger confirm=[model.confirm_service integerValue];
        if(confirm==0){
            self.affirmBtn.hidden=YES;
            [self.affirmBtn setTitle:@"" forState:UIControlStateNormal];
        }
        if(confirm==1){
            self.affirmBtn.hidden=NO;
            self.affirmBtn.cornerRadius=25/2;
            self.affirmBtn.borderWidth=1;
            self.affirmBtn.borderColor = RGB(255, 99, 101);
            self.affirmBtn.clipsToBounds = YES;
            [self.affirmBtn setTitle:@"确认送达" forState:UIControlStateNormal];
            [self.affirmBtn addTarget:self action:@selector(affirmBtnAction)];
        }
        
        
        CGFloat sumHintLBW=[self.sumHintLB.text kr_getWidthWithTextHeight:15 font:11];
        CGFloat maxLBW=FNDeviceWidth-20-10-105-130;
        if(sumHintLBW>maxLBW){
           sumHintLBW=maxLBW;
        }
//        self.sumHintLB.sd_resetLayout
//        .leftSpaceToView(self.imgView, 15).topSpaceToView(self.sumLB, 1).widthIs(sumHintLBW).heightIs(15);
        
    }
}
//取消申请退款
-(void)cancelRefundAction{
    if ([self.delegate respondsToSelector:@selector(didmeMemberCancelIndentitAction:)]) {
        [self.delegate didmeMemberCancelRefundAction:self.index];
    }
}
//取消订单
-(void)cancelIndentitAction{
    if ([self.delegate respondsToSelector:@selector(didmeMemberCancelIndentitAction:)]) {
        [self.delegate didmeMemberCancelIndentitAction:self.index];
    }
}
//评价
-(void)evaluateAction{
    if ([self.delegate respondsToSelector:@selector(didmeMemberEvaluateIndentitAction:)]) {
        [self.delegate didmeMemberEvaluateIndentitAction:self.index];
    }
}
//确认送达
-(void)affirmBtnAction{
    if ([self.delegate respondsToSelector:@selector(didmeMemberAffirmIndentitAction:)]) {
        [self.delegate didmeMemberAffirmIndentitAction:self.index];
    }
}
@end
