//
//  FNcandiesPrincipalTaskCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesPrincipalTaskCell.h"

@implementation FNcandiesPrincipalTaskCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    
    self.bgImgView=[[UIImageView alloc]init];
    self.lineView=[[UIImageView alloc]init];
    self.title1LB=[[UILabel alloc]init];
    self.title2LB=[[UILabel alloc]init];
    self.timeLB=[[UILabel alloc]init];
    self.numberLB=[[UILabel alloc]init];
    self.topBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.baseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightHintLB=[[UILabel alloc]init];
    self.rightValLB=[[UILabel alloc]init];
    
    [self addSubview:self.bgImgView];
    [self addSubview:self.lineView];
    [self addSubview:self.title1LB];
    [self addSubview:self.title2LB];
    [self addSubview:self.timeLB];
    [self addSubview:self.numberLB];
    [self addSubview:self.topBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.baseBtn];
    [self addSubview:self.rightHintLB];
    [self addSubview:self.rightValLB];
    
    //self.lineView.clipsToBounds = YES;
    
    self.title1LB.font=kFONT15;
    self.title1LB.textColor=[UIColor whiteColor];
    self.title1LB.textAlignment=NSTextAlignmentCenter;
    
    self.title2LB.font=kFONT12;
    self.title2LB.textColor=[UIColor whiteColor];
    self.title2LB.textAlignment=NSTextAlignmentCenter;
    
    self.timeLB.font=kFONT12;
    self.timeLB.textColor=RGB(36, 36, 42);
    self.timeLB.textAlignment=NSTextAlignmentLeft;
    
    self.numberLB.font=kFONT12;
    self.numberLB.textColor=RGB(36, 36, 42);
    self.numberLB.textAlignment=NSTextAlignmentLeft;
    
    self.rightHintLB.font=kFONT12;
    self.rightHintLB.textColor=RGB(36, 36, 42);
    self.rightHintLB.textAlignment=NSTextAlignmentCenter;
    
    self.rightValLB.font=[UIFont systemFontOfSize:30];
    self.rightValLB.textColor=RGB(255, 150, 20);
    self.rightValLB.textAlignment=NSTextAlignmentCenter;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 5).rightSpaceToView(self, 5).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 30).rightSpaceToView(self, 30).topSpaceToView(self, 45).bottomSpaceToView(self, 2);
    
    self.title1LB.frame=CGRectMake(15, 8, 75, 25);
    //self.title1LB.sd_layout
    //.leftSpaceToView(self, 15).widthIs(75).topSpaceToView(self, 8).heightIs(25);
    
    self.title2LB.sd_layout
    .centerXEqualToView(self).widthIs(65).topSpaceToView(self, 51).heightIs(18);
    
    self.rightHintLB.sd_layout
    .rightSpaceToView(self, 28).topSpaceToView(self, 68).widthIs(110).heightIs(13);
    
    self.rightValLB.sd_layout
    .rightSpaceToView(self, 28).topSpaceToView(self.rightHintLB, 10).widthIs(110).heightIs(25);
    
    self.rightBtn.sd_layout
    .centerXEqualToView(self.rightValLB).bottomSpaceToView(self, 15).widthIs(65).heightIs(22);
    
    self.topBtn.sd_layout
    .leftSpaceToView(self, 45).topSpaceToView(self, 68).rightSpaceToView(self, 135).heightIs(19);
    self.topBtn.imageView.sd_layout
    .leftEqualToView(self.topBtn).centerYEqualToView(self.topBtn).widthIs(16).heightIs(19);
    self.topBtn.titleLabel.sd_layout
    .leftSpaceToView(self.topBtn, 22).rightEqualToView(self.topBtn).heightIs(19).centerYEqualToView(self.topBtn);
    self.topBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    
    self.baseBtn.sd_layout
    .leftSpaceToView(self, 45).bottomSpaceToView(self, 15).rightSpaceToView(self, 135).heightIs(22);
    self.baseBtn.imageView.sd_layout
    .leftEqualToView(self.baseBtn).centerYEqualToView(self.baseBtn).widthIs(18).heightIs(22);
    self.baseBtn.titleLabel.sd_layout
    .leftSpaceToView(self.baseBtn, 22).rightEqualToView(self.baseBtn).heightIs(19).centerYEqualToView(self.baseBtn);
    self.baseBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    
    self.timeLB.sd_layout
    .leftSpaceToView(self, 70).topSpaceToView(self.topBtn, 5).rightSpaceToView(self, 135).heightIs(16);
    
    self.numberLB.sd_layout
    .leftSpaceToView(self, 70).topSpaceToView(self.timeLB, 5).rightSpaceToView(self, 135).heightIs(16);
    self.bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.rightBtn addTarget:self action:@selector(rightClick)];
}
-(void)rightClick{
    if ([self.delegate respondsToSelector:@selector(inPrincipalTaskRtightAction:)]) {
        [self.delegate inPrincipalTaskRtightAction:self.model];
    }
}
-(void)setModel:(FNCandiesMyTaskModel *)model{
    _model=model;
    if(model){
        
        //self.lineView.borderWidth=1.5;
        //self.lineView.borderColor = [UIColor colorWithHexString:model.color];
        //self.lineView.cornerRadius=10;
        //self.lineView.clipsToBounds = YES;
        self.title1LB.backgroundColor=[UIColor colorWithHexString:model.color];
        self.title1LB.text=model.name;
        //self.title2LB.text=model.cate_name;
        self.timeLB.text=[NSString stringWithFormat:@"%@ %@",model.str,model.str1];
        self.numberLB.text=[NSString stringWithFormat:@"%@ %@",model.str2,model.str3];
        self.rightHintLB.text=model.need_str;
        self.rightValLB.text=model.need_count;
        
        [self.topBtn sd_setImageWithURL:URL(model.left_icon) forState:UIControlStateNormal];
        [self.baseBtn sd_setImageWithURL:URL(model.qkb_icon) forState:UIControlStateNormal];
        [self.rightBtn sd_setBackgroundImageWithURL:URL(model.btn) forState:UIControlStateNormal];
        
        [self.topBtn setTitleColor:RGB(36, 36, 42) forState:UIControlStateNormal];
        [self.baseBtn setTitleColor:RGB(36, 36, 42) forState:UIControlStateNormal];
        
        [self.topBtn setTitle:model.str forState:UIControlStateNormal];
        [self.baseBtn setTitle:model.reward_str forState:UIControlStateNormal];
        [self.lineView setUrlImg:model.bj_img];
        
        CGFloat title1LBW=[self.title1LB.text kr_getWidthWithTextHeight:25 font:15];
        if(title1LBW>150){
           title1LBW=150;
        }
        self.title1LB.frame=CGRectMake(15, 8, title1LBW+10, 25);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.title1LB.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(12.5, 12.5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.title1LB.bounds;
        maskLayer.path = maskPath.CGPath;
        self.title1LB.layer.mask = maskLayer;
        
        [self.title1LB setNeedsLayout];
    }
}
-(void)setBgImgUrl:(NSString *)bgImgUrl{
    _bgImgUrl=bgImgUrl;
    if(bgImgUrl){
        [self.bgImgView setUrlImg:bgImgUrl];
    }
}
@end
