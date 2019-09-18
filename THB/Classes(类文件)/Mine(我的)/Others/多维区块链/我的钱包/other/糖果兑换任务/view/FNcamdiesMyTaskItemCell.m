//
//  FNcamdiesMyTaskItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcamdiesMyTaskItemCell.h"

@implementation FNcamdiesMyTaskItemCell
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
    self.imgView=[[UIImageView alloc]init];
    self.titleLB=[[UILabel alloc]init];
    self.hintRTimeLB=[[UILabel alloc]init];
    self.hintLB=[[UILabel alloc]init];
    self.baseLB=[[UILabel alloc]init];
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.planBgView=[[UIImageView alloc]init];
    self.planImgView=[[UIView alloc]init];
    self.planLB=[[UILabel alloc]init];
    self.rightHintLB=[[UILabel alloc]init];
    self.rightValLB=[[UILabel alloc]init];
    [self addSubview:self.bgImgView];
    [self addSubview:self.imgView];
    [self addSubview:self.planBgView];
    [self addSubview:self.planImgView];
    [self addSubview:self.titleLB];
    [self addSubview:self.hintRTimeLB];
    [self addSubview:self.hintLB];
    [self addSubview:self.baseLB];
    [self addSubview:self.rightBtn];
    [self addSubview:self.planLB];
    [self addSubview:self.rightHintLB];
    [self addSubview:self.rightValLB];
    
    self.titleLB.font=kFONT12;
    self.titleLB.textColor=RGB(25, 24, 28);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintRTimeLB.font=kFONT10;
    self.hintRTimeLB.textColor=RGB(147, 148, 148);
    self.hintRTimeLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=kFONT10;
    self.hintLB.textColor=RGB(147, 148, 148);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.baseLB.font=[UIFont systemFontOfSize:9];
    self.baseLB.textColor=RGB(147, 148, 148);
    self.baseLB.textAlignment=NSTextAlignmentLeft;
    
    
    self.planLB.textAlignment=NSTextAlignmentLeft;
    
    self.rightHintLB.font=[UIFont systemFontOfSize:9];
    self.rightHintLB.textColor=RGB(25, 24, 28);
    self.rightHintLB.textAlignment=NSTextAlignmentCenter;
    
    self.rightValLB.font=[UIFont systemFontOfSize:24];
    self.rightValLB.textColor=RGB(255, 150, 20);
    self.rightValLB.textAlignment=NSTextAlignmentCenter;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 5).rightSpaceToView(self, 5).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 26).centerYEqualToView(self).widthIs(60).heightIs(60);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.imgView, 15).rightSpaceToView(self, 95).topSpaceToView(self, 13).heightIs(19);
    
    self.hintRTimeLB.sd_layout
    .leftSpaceToView(self.imgView, 15).rightSpaceToView(self, 95).topSpaceToView(self.titleLB, 2).heightIs(14);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self.imgView, 15).rightSpaceToView(self, 95).topSpaceToView(self.hintRTimeLB, 2).heightIs(14);
    
    self.rightHintLB.sd_layout
    .rightSpaceToView(self, 20).topEqualToView(self.imgView).widthIs(85).heightIs(13);
    
    self.rightValLB.sd_layout
    .rightSpaceToView(self, 20).centerYEqualToView(self).widthIs(85).heightIs(25);
    
    self.rightBtn.sd_layout
    .centerXEqualToView(self.rightHintLB).topSpaceToView(self.rightValLB, 2).widthIs(65).heightIs(22);
    //.centerXEqualToView(self.rightHintLB).bottomEqualToView(self.imgView).widthIs(65).heightIs(22);
    
    self.baseLB.sd_layout
    .leftSpaceToView(self.imgView, 15).bottomSpaceToView(self, 0).rightSpaceToView(self, 95).heightIs(13);
    
    self.planBgView.sd_layout
    .leftSpaceToView(self.imgView, 15).rightSpaceToView(self, 151).heightIs(9).bottomSpaceToView(self.baseLB, 4);
    //.leftSpaceToView(self.imgView, 15).rightSpaceToView(self, 151).heightIs(9).bottomSpaceToView(self.baseLB, 4);
    self.planImgView.sd_layout
    .leftSpaceToView(self.imgView, 15).rightSpaceToView(self, 151).heightIs(9).bottomSpaceToView(self.baseLB, 4);
    
    self.planLB.sd_layout
    .leftSpaceToView(self.planBgView, 7).centerYEqualToView(self.planBgView).rightSpaceToView(self, 95).heightIs(16);
    //.leftSpaceToView(self.planBgView, 7).centerYEqualToView(self.planBgView).rightSpaceToView(self, 95).heightIs(16);
   
    self.bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImgView.clipsToBounds = YES;
    
    self.planBgView.cornerRadius=9/2;
    self.planImgView.cornerRadius=9/2;
    
    [self.rightBtn addTarget:self action:@selector(rightClick)];
}
-(void)rightClick{
    if ([self.delegate respondsToSelector:@selector(inMyTaskRtightAction:)]) {
        [self.delegate inMyTaskRtightAction:self.model];
    }
}
-(void)setModel:(FNCandiesMyTaskModel *)model{
    _model=model;
    if(model){
        [self.imgView setUrlImg:model.icon];
        [self.rightBtn sd_setBackgroundImageWithURL:URL(model.btn) forState:UIControlStateNormal];
        self.titleLB.text=model.title;
        if([model.type isEqualToString:@"task"]){
            self.hintRTimeLB.text=model.str;
            self.hintLB.text=model.condition;
            self.baseLB.text=model.expire_time;
            self.planLB.textColor=[UIColor colorWithHexString:model.progress_color1];
            self.planLB.font=kFONT12;
            self.hintLB.textColor=RGB(147, 148, 148);
        //self.rightBtn.sd_resetLayout
        //.centerXEqualToView(self.rightHintLB).centerYEqualToView(self).widthIs(65).heightIs(22);
        //self.planBgView.sd_resetLayout
        //.leftSpaceToView(self.imgView, 15).rightSpaceToView(self, 151).heightIs(9).bottomSpaceToView(self.baseLB, 4);
        //self.planLB.sd_resetLayout
        //.leftSpaceToView(self.planBgView, 7).centerYEqualToView(self.planBgView).rightSpaceToView(self, 95).heightIs(16);
        self.planBgView.backgroundColor=[UIColor colorWithHexString:model.progress_bg_color];
        if([model.complete kr_isNotEmpty]&&[model.complete kr_isNotEmpty]){
            self.planLB.text=[NSString stringWithFormat:@"%@/%@",model.complete,model.total];
            CGFloat fulfillFl=[model.complete floatValue];
            CGFloat allFl=[model.total floatValue];
            CGFloat bgAllW=(FNDeviceWidth-252)*(fulfillFl/allFl);
            self.planImgView.sd_resetLayout
            .leftSpaceToView(self.imgView, 15).widthIs(bgAllW).heightIs(9).bottomSpaceToView(self.baseLB, 4);
            [self.planImgView az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:model.progress_color],[UIColor colorWithHexString:model.progress_color1]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
        }
            self.planLB.hidden=NO;
            self.planBgView.hidden=NO;
            self.planImgView.hidden=NO;
            self.hintLB.sd_resetLayout
            .leftSpaceToView(self.imgView, 15).rightSpaceToView(self, 95).topSpaceToView(self.hintRTimeLB, 2).heightIs(14);
        }
        else{
            self.baseLB.text=@"";
            self.hintRTimeLB.text=@"";
            self.planLB.text=@"";
            self.planBgView.hidden=YES;
            self.planImgView.hidden=YES;
            self.planLB.hidden=YES;
            self.hintLB.textColor=RGB(25, 24, 28);
            self.hintLB.text=[NSString stringWithFormat:@"今日累计奖励: %@",model.lq_count];
            if([model.lq_count kr_isNotEmpty]){
               [self.hintLB fn_changeColorWithTextColor:RGB(255, 150, 20) changeText:model.lq_count];
               [self.hintLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:12] changeText:model.lq_count];
            }
            self.hintLB.sd_resetLayout
            .leftSpaceToView(self.imgView, 15).rightSpaceToView(self, 95).topSpaceToView(self.hintRTimeLB,7).heightIs(16);
        }
        self.rightHintLB.text=model.tips1;
        self.rightValLB.text=model.counts;
    }
}
-(void)setBgImgUrl:(NSString *)bgImgUrl{
    _bgImgUrl=bgImgUrl;
    if(bgImgUrl){
        [self.bgImgView setUrlImg:bgImgUrl];
    }
}
@end
