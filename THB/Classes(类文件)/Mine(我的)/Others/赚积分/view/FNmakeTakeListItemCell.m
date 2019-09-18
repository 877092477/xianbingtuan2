//
//  FNmakeTakeListItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmakeTakeListItemCell.h"

@implementation FNmakeTakeListItemCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNmakeTakeListItemCellID";
    FNmakeTakeListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews{
    self.headView=[[UIImageView alloc]init];
    self.titleLB=[[UILabel alloc]init];
    self.referralLB=[[UILabel alloc]init];
    self.detailsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.sumBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.causeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.line=[[UIView alloc]init];
    [self addSubview:self.headView];
    [self addSubview:self.titleLB];
    [self addSubview:self.referralLB];
    [self addSubview:self.sumBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.detailsBtn];
    [self addSubview:self.causeBtn];
    [self addSubview:self.line];
    
    self.integralImg=[[UIImageView alloc]init];
    self.integralLB=[[UILabel alloc]init];
    self.moneyImg=[[UIImageView alloc]init];
    self.moneyLB=[[UILabel alloc]init];
    [self addSubview:self.integralImg];
    [self addSubview:self.integralLB];
    [self addSubview:self.moneyImg];
    [self addSubview:self.moneyLB];
    self.integralLB.font=kFONT11;
    self.moneyLB.font=kFONT11;
    
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    self.titleLB.font=kFONT15;
    self.referralLB.textColor=RGB(153, 153, 153);
    self.referralLB.textAlignment=NSTextAlignmentLeft;
    self.referralLB.font=kFONT12;
    self.sumBtn.titleLabel.font=kFONT15;
    [self.sumBtn setTitleColor:RGB(250, 74, 57) forState:UIControlStateNormal];
    self.line.backgroundColor=RGB(247, 246, 249);
    [self.rightBtn addTarget:self action:@selector(rightBtnAction)];
    [self.causeBtn addTarget:self action:@selector(causeBtnAction)];
    self.causeBtn.hidden=YES;
    self.causeBtn.titleLabel.font=kFONT10;
    [self incomposition];
}
-(void)incomposition{
    self.headView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 15).widthIs(37).heightIs(37);
    self.titleLB.sd_layout
    .leftSpaceToView(self, 60).topSpaceToView(self, 15).heightIs(20).widthIs(70);
    self.referralLB.sd_layout
    .leftSpaceToView(self, 60).topSpaceToView(self, 68).heightIs(20).rightSpaceToView(self, 80);
    //[self.referralLB setSingleLineAutoResizeWithMaxWidth:250];
    self.sumBtn.sd_layout
    .leftSpaceToView(self, 140).topSpaceToView(self, 15).heightIs(20).widthIs(70);
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 5).topSpaceToView(self, 15).heightIs(28).widthIs(73);
    self.detailsBtn.sd_layout
    .rightSpaceToView(self, 5).topSpaceToView(self, 50).heightIs(18).widthIs(68);
    
    self.line.sd_layout
    .leftSpaceToView(self, 60).rightSpaceToView(self, 5).bottomSpaceToView(self, 0).heightIs(1);
    
    self.integralImg.sd_layout
    .leftSpaceToView(self, 60).topSpaceToView(self, 40).widthIs(18).heightIs(18);
    
    self.integralLB.sd_layout
    .leftSpaceToView(self.integralImg, 5).centerYEqualToView(self.integralImg).heightIs(20).widthIs(50);
    
    self.moneyImg.sd_layout
    .leftSpaceToView(self, 150).topSpaceToView(self, 40).widthIs(18).heightIs(18);
    
    self.moneyLB.sd_layout
    .leftSpaceToView(self.moneyImg, 5).centerYEqualToView(self.moneyImg).heightIs(20).widthIs(50);
    
    self.rightBtn.imageView.sd_layout
    .leftEqualToView(self.rightBtn).rightEqualToView(self.rightBtn).topEqualToView(self.rightBtn).bottomEqualToView(self.rightBtn); 
    self.rightBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.rightBtn.imageView.clipsToBounds=YES;
    self.rightBtn.cornerRadius=28/2;
    
    self.detailsBtn.imageView.sd_layout
    .leftEqualToView(self.detailsBtn).rightEqualToView(self.detailsBtn).topEqualToView(self.detailsBtn).bottomEqualToView(self.detailsBtn);
    self.detailsBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.detailsBtn.imageView.clipsToBounds=YES;
    
    self.causeBtn.sd_layout
    .rightSpaceToView(self, 5).topSpaceToView(self, 78).heightIs(18).widthIs(68);
    self.causeBtn.cornerRadius=5/2;
}
-(void)setModel:(FNMakeTaskItemTmodel *)model{
    _model=model;
    if (model) {
        [self.headView setUrlImg:model.icon];
        self.titleLB.text=model.name;
        self.referralLB.text=model.describe;
        CGFloat nameW= [model.name kr_getWidthWithTextHeight:20 font:15];
        if(nameW>100){
            nameW=100;
        }
        if([model.name_color kr_isNotEmpty]){
           self.titleLB.textColor=[UIColor colorWithHexString:model.name_color];
        }
        if([model.describe_color kr_isNotEmpty]){
           self.referralLB.textColor=[UIColor colorWithHexString:model.describe_color];
        }
        self.titleLB.sd_layout
        .leftSpaceToView(self, 60).topSpaceToView(self, 15).heightIs(20).widthIs(nameW);
//        [self.sumBtn setTitleColor:[UIColor colorWithHexString:model.jifen_color] forState:UIControlStateNormal];
//        [self.sumBtn setTitle:integral forState:UIControlStateNormal];
//        [self.sumBtn sd_setImageWithURL:URL(model.jifen_btn) forState:UIControlStateNormal];
//        self.sumBtn.sd_layout
//        .leftSpaceToView(self, 60+nameW+20).topSpaceToView(self, 15).heightIs(20).widthIs(integralW+25);
//
//        [self.sumBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:2];
        NSInteger state=[model.btn_status integerValue];
        if (state==1) {
            //[self.rightBtn sd_setBackgroundImageWithURL:URL(model.finish_btn_wrods) forState:UIControlStateNormal];
            [self.rightBtn sd_setImageWithURL:URL(model.finish_btn_wrods) forState:UIControlStateNormal];
        }
        if (state==2) {
            //[self.rightBtn sd_setBackgroundImageWithURL:URL(model.unfinish_btn_wrods) forState:UIControlStateNormal];
            [self.rightBtn sd_setImageWithURL:URL(model.unfinish_btn_wrods) forState:UIControlStateNormal];
        }
        if (state==3) {
            //[self.rightBtn sd_setBackgroundImageWithURL:URL(model.lingqu_btn_wrods) forState:UIControlStateNormal];
            [self.rightBtn sd_setImageWithURL:URL(model.lingqu_btn_wrods) forState:UIControlStateNormal];
        }
        if (state==4) {
            [self.rightBtn sd_setImageWithURL:URL(model.in_audit_btn) forState:UIControlStateNormal];
        }
        if (state==5) {
            [self.rightBtn sd_setImageWithURL:URL(model.reaudit_btn) forState:UIControlStateNormal];
            self.causeBtn.hidden=NO;
            [self.causeBtn setTitle:model.fail_str forState:UIControlStateNormal];
            [self.causeBtn setTitleColor:[UIColor colorWithHexString:model.fail_fontcolor] forState:UIControlStateNormal];
            [self.causeBtn setBackgroundColor:[UIColor colorWithHexString:model.fail_color]];
            CGFloat causeBtnW=[model.fail_str kr_getWidthWithTextHeight:18 font:10];
            if(causeBtnW>80){
               causeBtnW=80;
            }
            self.causeBtn.sd_resetLayout
            .rightSpaceToView(self, 5).topSpaceToView(self, 78).heightIs(18).widthIs(causeBtnW+5);
        }else{
            self.causeBtn.hidden=YES;
        }
        if(model.lineState==1){
            self.line.hidden=YES;
        }else{
            self.line.hidden=NO;
        }
        
        NSString *jf=model.integral;
        NSString *yj=model.commission;
        
        [self.integralImg setUrlImg:model.jifen_btn];
        self.integralLB.textColor=[UIColor colorWithHexString:model.jifen_color];
        self.integralLB.text=model.jf_text;
        [self.moneyImg setUrlImg:model.yongjin_btn];
        self.moneyLB.textColor=[UIColor colorWithHexString:model.yj_color];
        self.moneyLB.text=model.yj_text;
        [self.integralLB fn_changeFontWithTextFont:kFONT17 changeText:jf];
        [self.moneyLB fn_changeFontWithTextFont:kFONT17 changeText:yj];
        
        NSString *integral=model.jf_text;
        CGFloat integralW= [integral kr_getWidthWithTextHeight:20 font:17];
        if(integralW>90){
           integralW=90;
        }
        NSString *money=model.jf_text;
        CGFloat moneyW= [money kr_getWidthWithTextHeight:20 font:17];
        if(moneyW>90){
           moneyW=90;
        }
        CGFloat moneyImageleft=60+18+5+integralW+10;
        NSInteger award_type=[model.award_type integerValue];
        //0 显示积分，1显示佣金 ，2显示积分和佣金
        if(award_type==0){
           self.integralImg.hidden=NO;
           self.integralLB.hidden=NO;
           self.moneyImg.hidden=YES;
           self.moneyLB.hidden=YES;
        }else if(award_type==1){
            self.integralImg.hidden=YES;
            self.integralLB.hidden=YES;
            self.moneyImg.hidden=NO;
            self.moneyLB.hidden=NO;
            moneyImageleft=60;
        }else if(award_type==2){
            self.integralImg.hidden=NO;
            self.integralLB.hidden=NO;
            self.moneyImg.hidden=NO;
            self.moneyLB.hidden=NO;
            moneyImageleft=60+18+5+integralW+15;
        }
        
        self.integralLB.sd_layout
        .leftSpaceToView(self.integralImg, 5).centerYEqualToView(self.integralImg).heightIs(20).widthIs(integralW);
        
        self.moneyImg.sd_layout
        .leftSpaceToView(self, moneyImageleft).topSpaceToView(self, 40).widthIs(18).heightIs(18);
        
        self.moneyLB.sd_layout
        .leftSpaceToView(self.moneyImg, 5).centerYEqualToView(self.moneyImg).heightIs(20).widthIs(moneyW);
        
        if([model.type isEqualToString:@"custom"]){
            //custom 表示自定义任务 
            [self.detailsBtn sd_setImageWithURL:URL(model.show_explain_btn) forState:UIControlStateNormal];
            [self.detailsBtn addTarget:self action:@selector(detailsBtnAction)];
            self.detailsBtn.hidden=NO;
        }else{
            self.detailsBtn.hidden=YES;
        }
    }
}
-(void)rightBtnAction{
    if ([self.delegate respondsToSelector:@selector(inMakeTakeListItemAction:)]) {
        [self.delegate inMakeTakeListItemAction:self.indexPath];
    }
}
-(void)detailsBtnAction{
    if ([self.delegate respondsToSelector:@selector(inMakeTakeListItemDetailsBtnAction:)]) {
        [self.delegate inMakeTakeListItemDetailsBtnAction:self.indexPath];
    }
    
}

-(void)causeBtnAction{
    if ([self.delegate respondsToSelector:@selector(inMakeTakeListcauseOfFailureAction:)]) {
        [self.delegate inMakeTakeListcauseOfFailureAction:self.indexPath];
    }
}
@end
