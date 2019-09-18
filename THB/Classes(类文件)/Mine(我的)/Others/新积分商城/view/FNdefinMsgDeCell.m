//
//  FNdefinMsgDeCell.m
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//头部cell 35
#import "FNdefinMsgDeCell.h"

@implementation FNdefinMsgDeCell
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

-(void)initUI{ 
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.hidden=YES;
    self.rightBtn.titleLabel.font=kFONT11;
    [self.rightBtn setTitle:@"积分明细" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:RGB(140,140,140) forState:UIControlStateNormal];
    [self.rightBtn setImage:IMAGE(@"FJ_minRight_img") forState:UIControlStateNormal];
    [self addSubview:self.rightBtn];
    
    self.leftLB=[UILabel new];
    self.leftLB.font=kFONT12;
    self.leftLB.textColor=FNBlackColor;
    self.leftLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.leftLB];
    
    self.rightBtn.sd_layout
    .heightIs(20).widthIs(70).centerYEqualToView(self).rightSpaceToView(self, 10);
    [self.rightBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:9];
    
    self.leftLB.sd_layout
    .heightIs(20).centerYEqualToView(self).leftSpaceToView(self, 10).rightSpaceToView(self.rightBtn, 20);
    
    
}
-(void)setModelArr:(NSArray *)modelArr{
    _modelArr=modelArr;
    if (modelArr.count>0) {
        FNDefiniteListItemModel *model=[FNDefiniteListItemModel mj_objectWithKeyValues:modelArr[0]];
        self.leftLB.text=[NSString stringWithFormat:@"%@ %@  %@ %@",model.str2,model.commission,model.str3,model.integral];
        //@"我的余额(元): 42  我的积分: 124";
        self.rightBtn.hidden=NO;
    }
}
@end
