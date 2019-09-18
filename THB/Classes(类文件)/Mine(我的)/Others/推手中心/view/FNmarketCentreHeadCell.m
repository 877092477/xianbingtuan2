//
//  FNmarketCentreHeadCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmarketCentreHeadCell.h"

@implementation FNmarketCentreHeadCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.sumLB=[[UILabel alloc]init];
    [self addSubview:self.sumLB];
    
    self.surplusTitleLB=[[UILabel alloc]init];
    [self addSubview:self.surplusTitleLB];
    self.surplusLB=[[UILabel alloc]init];
    [self addSubview:self.surplusLB];
    self.gainTitleLB=[[UILabel alloc]init];
    [self addSubview:self.gainTitleLB];
    self.gainLB=[[UILabel alloc]init];
    [self addSubview:self.gainLB];
    self.takesTitleLB=[[UILabel alloc]init];
    [self addSubview:self.takesTitleLB];
    self.takesLB=[[UILabel alloc]init];
    [self addSubview:self.takesLB];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    UIView *ceLineView=[[UIView alloc]init];
    [self addSubview:ceLineView];
    
    self.leftTopBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.leftTopBtn];
    
    self.rightTopBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightTopBtn];
    
    self.leftBaseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.leftBaseBtn];
    
    self.rightBaseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBaseBtn];
    
    self.leftTopBtn.titleLabel.font=kFONT13;
    self.leftTopBtn.titleLabel.numberOfLines=2;
    [self.leftTopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.rightTopBtn.titleLabel.font=kFONT13;
    [self.rightTopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.leftBaseBtn.titleLabel.font=kFONT15;
    [self.leftBaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftBaseBtn setTitleColor:RGB(255, 63, 63) forState:UIControlStateSelected];
    
    self.rightBaseBtn.titleLabel.font=kFONT15;
    [self.rightBaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightBaseBtn setTitleColor:RGB(255, 63, 63) forState:UIControlStateSelected];
    
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=[UIColor whiteColor];
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    
    self.sumLB.font=[UIFont systemFontOfSize:30];
    self.sumLB.textColor=[UIColor whiteColor];
    self.sumLB.textAlignment=NSTextAlignmentCenter;
    
    self.surplusTitleLB.font=[UIFont systemFontOfSize:12];
    self.surplusTitleLB.textColor=[UIColor whiteColor];
    self.surplusTitleLB.textAlignment=NSTextAlignmentCenter;
    self.surplusLB.font=[UIFont systemFontOfSize:12];
    self.surplusLB.textColor=[UIColor whiteColor];
    self.surplusLB.textAlignment=NSTextAlignmentCenter;
    self.gainTitleLB.font=[UIFont systemFontOfSize:12];
    self.gainTitleLB.textColor=[UIColor whiteColor];
    self.gainTitleLB.textAlignment=NSTextAlignmentCenter;
    self.gainLB.font=[UIFont systemFontOfSize:12];
    self.gainLB.textColor=[UIColor whiteColor];
    self.gainLB.textAlignment=NSTextAlignmentCenter;
    self.takesTitleLB.font=[UIFont systemFontOfSize:12];
    self.takesTitleLB.textColor=[UIColor whiteColor];
    self.takesTitleLB.textAlignment=NSTextAlignmentCenter;
    self.takesLB.font=[UIFont systemFontOfSize:12];
    self.takesLB.textColor=[UIColor whiteColor];
    self.takesLB.textAlignment=NSTextAlignmentCenter;
    
    CGFloat topGap=SafeAreaTopHeight+10;
    CGFloat meanLBWide=(FNDeviceWidth-6)/3;
    CGFloat meanBtnWide=FNDeviceWidth/2+13;
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).rightSpaceToView(self, 15).heightIs(16).topSpaceToView(self, topGap);
    
    self.sumLB.sd_layout
    .leftSpaceToView(self, 15).rightSpaceToView(self, 15).heightIs(34).topSpaceToView(self.titleLB, 11);
    
    ceLineView.sd_layout
    .centerYEqualToView(self).centerXEqualToView(self).widthIs(1).heightIs(10);
    
    self.leftTopBtn.sd_layout
    .rightSpaceToView(ceLineView, 17).heightIs(38).widthIs(109).topSpaceToView(self.sumLB, 14);
    self.leftTopBtn.titleLabel.sd_layout
    .leftSpaceToView(self.leftTopBtn, 7).topSpaceToView(self.leftTopBtn, 0).rightSpaceToView(self.leftTopBtn, 7).bottomSpaceToView(self.leftTopBtn, 0);
    self.leftTopBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    self.rightTopBtn.sd_layout
    .leftSpaceToView(ceLineView, 17).heightIs(38).widthIs(109).topSpaceToView(self.sumLB, 14);
    
    self.gainTitleLB.sd_layout
    .centerXEqualToView(self).widthIs(meanLBWide).topSpaceToView(self.leftTopBtn, 20).heightIs(16);
    self.gainLB.sd_layout
    .centerXEqualToView(self).widthIs(meanLBWide).topSpaceToView(self.gainTitleLB, 6).heightIs(17);
    
    self.surplusTitleLB.sd_layout
    .rightSpaceToView(self.gainTitleLB, 0).heightIs(16).widthIs(meanLBWide).centerYEqualToView(self.gainTitleLB);
    self.surplusLB.sd_layout
    .rightSpaceToView(self.gainTitleLB, 0).heightIs(17).widthIs(meanLBWide).centerYEqualToView(self.gainLB);
    
    self.takesTitleLB.sd_layout
    .leftSpaceToView(self.gainTitleLB, 0).heightIs(16).widthIs(meanLBWide).centerYEqualToView(self.gainTitleLB);
    self.takesLB.sd_layout
    .leftSpaceToView(self.gainTitleLB, 0).heightIs(17).widthIs(meanLBWide).centerYEqualToView(self.gainLB);
    
    self.leftBaseBtn.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 37).widthIs(meanBtnWide).heightIs(33);
    
    self.rightBaseBtn.sd_layout
    .rightSpaceToView(self, 0).bottomSpaceToView(self, 37).widthIs(meanBtnWide).heightIs(33);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(1);
    
    
    CGFloat listTopGapt=267+SafeAreaTopHeight;
    self.listView=[[FNmarScreensfView alloc]init];
    [self addSubview:self.listView];
    self.listView.frame=CGRectMake(0, listTopGapt, FNDeviceWidth, 36);
    self.listView.sd_resetLayout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 1).heightIs(36);
}

-(void)setModel:(FNMarketCentreModel *)model{
    _model=model;
    if(model){
        self.listView.backgroundColor=[UIColor whiteColor];
        [self.leftBaseBtn setBackgroundImage:IMAGE(@"FN_ma_LiTmimg") forState:UIControlStateNormal];
        [self.leftBaseBtn setBackgroundImage:IMAGE(@"FN_ma_LiWSimg") forState:UIControlStateSelected];
        [self.rightBaseBtn setBackgroundImage:IMAGE(@"FN_ma_RiTmimg") forState:UIControlStateNormal];
        [self.rightBaseBtn setBackgroundImage:IMAGE(@"FN_ma_RiWimg") forState:UIControlStateSelected];
        
        self.leftTopBtn.borderWidth=1;
        self.leftTopBtn.borderColor = [UIColor whiteColor];
        self.leftTopBtn.cornerRadius=38/2;
        self.leftTopBtn.clipsToBounds = YES;
        self.rightTopBtn.borderWidth=1;
        self.rightTopBtn.borderColor = [UIColor whiteColor];
        self.rightTopBtn.cornerRadius=38/2;
        self.rightTopBtn.clipsToBounds = YES;
        
        self.titleLB.text=model.commission_str;
        self.sumLB.text=model.commission;
        self.surplusTitleLB.text=model.str1;
        self.surplusLB.text=model.commission;
        self.gainTitleLB.text=model.str2;
        self.gainLB.text=model.shouru;
        self.takesTitleLB.text=model.str3;
        self.takesLB.text=model.tixian;
        [self.leftTopBtn setTitle:[NSString stringWithFormat:@"复制邀请码%@",model.code] forState:UIControlStateNormal];
        [self.rightTopBtn setTitle:@"立即提现" forState:UIControlStateNormal];
        
        //self.listView.dataArr=model.
        self.lineView.backgroundColor=RGB(232, 232, 232);
        NSArray *listArr=model.select;
        if(listArr.count>0){
           FNMarketCentreSelectModel *leftModel=[FNMarketCentreSelectModel mj_objectWithKeyValues:listArr[0]];
           [self.leftBaseBtn setTitle:leftModel.name forState:UIControlStateNormal];
           [self.leftBaseBtn addTarget:self action:@selector(leftBaseBtnClick:)
                       forControlEvents:UIControlEventTouchUpInside];
        }
        if(listArr.count>1){
            FNMarketCentreSelectModel *rightModel=[FNMarketCentreSelectModel mj_objectWithKeyValues:listArr[1]];
            [self.rightBaseBtn setTitle:rightModel.name forState:UIControlStateNormal];
            [self.rightBaseBtn addTarget:self action:@selector(rightBaseBtnClick:)
                       forControlEvents:UIControlEventTouchUpInside];
        }
        [self.leftBaseBtn setTitleColor:[UIColor colorWithHexString:model.select_color] forState:UIControlStateSelected];
        [self.rightBaseBtn setTitleColor:[UIColor colorWithHexString:model.select_color] forState:UIControlStateSelected];
    }
}
-(void)leftBaseBtnClick:(UIButton*)btn{
    self.leftBaseBtn.selected=YES;
    self.rightBaseBtn.selected=NO;
    NSString *typeStr=@"order";
    NSArray *listArr=self.model.select;
    if(listArr.count>0){
        FNMarketCentreSelectModel *leftModel=[FNMarketCentreSelectModel mj_objectWithKeyValues:listArr[0]];
        typeStr=leftModel.type;
    }
    if ([self.delegate respondsToSelector:@selector(inMarketCentreHeadisSeletedType:withIndex:)]) {
        [self.delegate inMarketCentreHeadisSeletedType:typeStr withIndex:0];
    }
//    btn.selected=!btn.selected;
//    if(btn.selected==YES){
//
//    }else{
//
//    }
}
-(void)rightBaseBtnClick:(UIButton*)btn{
    self.leftBaseBtn.selected=NO;
    self.rightBaseBtn.selected=YES;
    NSString *typeStr=@"store";
    NSArray *listArr=self.model.select;
    if(listArr.count>0){
        FNMarketCentreSelectModel *rightModel=[FNMarketCentreSelectModel mj_objectWithKeyValues:listArr[1]];
        typeStr=rightModel.type;
    }
    if ([self.delegate respondsToSelector:@selector(inMarketCentreHeadisSeletedType:withIndex:)]) {
        [self.delegate inMarketCentreHeadisSeletedType:typeStr withIndex:1];
    }
//    btn.selected=!btn.selected;
//    if(btn.selected==YES){
//
//    }else{
//
//    }
}
-(void)setSeletedType:(NSString *)seletedType{
    _seletedType=seletedType;
    if([seletedType isEqualToString:@"order"]){
        self.leftBaseBtn.selected=YES;
        self.rightBaseBtn.selected=NO;
    }else{
        self.leftBaseBtn.selected=NO;
        self.rightBaseBtn.selected=YES;
    }
}
@end
