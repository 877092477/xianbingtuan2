//
//  FNmakeHotItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmakeHotItemCell.h"

@implementation FNmakeHotItemCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNmakeHotItemCellID";
    FNmakeHotItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    self.traceView=[[UIImageView alloc]init];
    self.titleLB=[[UILabel alloc]init];
    self.referralLB=[[UILabel alloc]init];
    self.numberLB=[[UILabel alloc]init];
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.sumLB=[[UILabel alloc]init];
    
    [self addSubview:self.headView];
    [self addSubview:self.traceView];
    [self addSubview:self.titleLB];
    [self addSubview:self.referralLB];
    [self addSubview:self.numberLB];
    [self addSubview:self.rightBtn];
    [self addSubview:self.sumLB];
    
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
    
    self.line=[[UIView alloc]init];
    [self addSubview:self.line];
    
    self.titleLB.font=kFONT15;
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft; 
    self.numberLB.textColor=RGB(250, 74, 57);
    self.numberLB.textAlignment=NSTextAlignmentLeft;
    self.numberLB.font=kFONT12;
    self.referralLB.textColor=RGB(153, 153, 153);
    self.referralLB.textAlignment=NSTextAlignmentLeft;
    self.referralLB.font=kFONT12;
    self.sumLB.textColor=RGB(249, 84, 49);
    self.sumLB.textAlignment=NSTextAlignmentRight;
    self.sumLB.font=[UIFont systemFontOfSize:24];
    self.line.backgroundColor=RGB(247, 246, 249);
    [self.rightBtn addTarget:self action:@selector(rightBtnAction)];
    [self incomposition];
}
-(void)incomposition{
    self.headView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 13).widthIs(37).heightIs(37);
    self.traceView.sd_layout
    .leftSpaceToView(self, 45).topSpaceToView(self, 65).widthIs(220).heightIs(103);
    self.titleLB.sd_layout
    .leftSpaceToView(self, 60).topSpaceToView(self, 15).heightIs(20);
    [self.titleLB setSingleLineAutoResizeWithMaxWidth:180];
    //self.numberLB.sd_layout
    //.leftSpaceToView(self, 60).topSpaceToView(self, 35).heightIs(20).widthIs(70);
    //[self.numberLB setSingleLineAutoResizeWithMaxWidth:180];
    
    self.sumLB.sd_layout
    .rightSpaceToView(self, 5).topSpaceToView(self, 105).heightIs(30).widthIs(80); 
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 5).heightIs(28).widthIs(73).topSpaceToView(self, 19);
    
    self.rightBtn.imageView.sd_layout
    .leftEqualToView(self.rightBtn).rightEqualToView(self.rightBtn).topEqualToView(self.rightBtn).bottomEqualToView(self.rightBtn);
    self.rightBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.rightBtn.imageView.clipsToBounds=YES;
    self.rightBtn.cornerRadius=28/2;
    
    self.integralImg.sd_layout
    .leftSpaceToView(self, 60).topSpaceToView(self, 40).widthIs(18).heightIs(18);
    
    self.integralLB.sd_layout
    .leftSpaceToView(self.integralImg, 5).centerYEqualToView(self.integralImg).heightIs(20).widthIs(50);
    
    self.moneyImg.sd_layout
    .leftSpaceToView(self, 150).topSpaceToView(self, 40).widthIs(18).heightIs(18);
    
    self.moneyLB.sd_layout
    .leftSpaceToView(self.moneyImg, 5).centerYEqualToView(self.moneyImg).heightIs(20).widthIs(50);
    
    self.referralLB.sd_layout
    .leftSpaceToView(self, 60).heightIs(40).rightSpaceToView(self, 20).topSpaceToView(self.traceView, 0);
    
//    self.line.sd_layout
//    .leftSpaceToView(self, 60).rightSpaceToView(self, 10).bottomSpaceToView(self, 41).heightIs(1);
    
    self.line.sd_layout
    .leftSpaceToView(self, 60).rightSpaceToView(self, 5).bottomSpaceToView(self, 0).heightIs(1);
}
-(void)setModel:(FNMakeTaskItemTmodel *)model{
    _model=model;
    if (model) {
        [self.headView setUrlImg:model.icon];
        self.titleLB.text=model.name;
        //self.numberLB.text=[NSString stringWithFormat:@"+%@",model.integral];
        self.referralLB.text=[NSString stringWithFormat:@"%@",model.describe];
        //self.sumLB.text=[NSString stringWithFormat:@"+%@",model.integral];
        self.titleLB.textColor=[UIColor colorWithHexString:model.name_color];
        //self.sumLB.textColor=[UIColor colorWithHexString:model.jifen_color];
        self.referralLB.textColor=[UIColor colorWithHexString:model.describe_color];
        
        [self.traceView setUrlImg:model.desc_img];
        
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
    }
}
-(void)rightBtnAction{
    if ([self.delegate respondsToSelector:@selector(inMakeHotItemCellAction:)]) {
        [self.delegate inMakeHotItemCellAction:self.indexPath];
    }
}
@end
