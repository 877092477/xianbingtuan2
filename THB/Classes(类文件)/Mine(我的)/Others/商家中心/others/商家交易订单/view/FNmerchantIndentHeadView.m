//
//  FNmerchantIndentHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchantIndentHeadView.h"

@implementation FNmerchantIndentHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews{
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    
    self.leftTitleLB=[[UILabel alloc]init];
    [self addSubview:self.leftTitleLB];
    
    self.leftSumLB=[[UILabel alloc]init];
    [self addSubview:self.leftSumLB];
    
    self.rightHintLB=[[UILabel alloc]init];
    [self addSubview:self.rightHintLB];
    
    self.expenseCountLB=[[UILabel alloc]init];
    [self addSubview:self.expenseCountLB];
    
    //self.expenseLB=[[UILabel alloc]init];
    //[self addSubview:self.expenseLB];
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    
    self.bgImgView.cornerRadius=5;
    self.bgImgView.clipsToBounds = YES;
    
    self.leftTitleLB.font=[UIFont systemFontOfSize:12];
    self.leftTitleLB.textColor=[UIColor whiteColor];
    self.leftTitleLB.textAlignment=NSTextAlignmentLeft;
    
    self.leftSumLB.font=[UIFont systemFontOfSize:21];
    self.leftSumLB.textColor=[UIColor whiteColor];
    self.leftSumLB.textAlignment=NSTextAlignmentLeft;
    
    self.rightHintLB.font=[UIFont systemFontOfSize:9];
    self.rightHintLB.textColor=[UIColor whiteColor];
    self.rightHintLB.textAlignment=NSTextAlignmentRight;
    
    self.expenseCountLB.font=[UIFont systemFontOfSize:12];
    self.expenseCountLB.textColor=RGB(60, 60, 60);
    self.expenseCountLB.textAlignment=NSTextAlignmentLeft;
    
    //self.expenseLB.font=[UIFont systemFontOfSize:12];
    //self.expenseLB.textColor=RGB(60, 60, 60);
    //self.expenseLB.textAlignment=NSTextAlignmentLeft;
    
    self.rightBtn.titleLabel.font=kFONT11;
    self.rightBtn.backgroundColor=[UIColor whiteColor];
    self.rightBtn.cornerRadius=23/2;
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; 
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 13).rightSpaceToView(self, 10).heightIs(68);
    
    self.leftTitleLB.sd_layout
    .leftSpaceToView(self, 25).topSpaceToView(self, 22).heightIs(16).widthIs(100);
    
    self.leftSumLB.sd_layout
    .leftSpaceToView(self, 25).topSpaceToView(self.leftTitleLB, 8).heightIs(24).widthIs(170);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 25).topSpaceToView(self, 25).heightIs(23).widthIs(75);
    
    self.rightHintLB.sd_layout
    .leftSpaceToView(self.leftSumLB, 10).rightSpaceToView(self, 25).topSpaceToView(self.rightBtn, 4).heightIs(14);
    
    self.expenseCountLB.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self.bgImgView, 0).rightSpaceToView(self, 0).heightIs(42);
    
}

-(void)setTopModel:(FNmerchantIndentModel *)topModel{
    _topModel=topModel;
    if(topModel){
        [self.bgImgView setUrlImg:topModel.top_bj];
        self.leftTitleLB.text=topModel.balance_text;
        self.leftSumLB.text=topModel.balance;
        self.rightHintLB.text=topModel.tixian_tips;
        self.leftTitleLB.textColor=[UIColor colorWithHexString:topModel.color];
        self.leftSumLB.textColor=[UIColor colorWithHexString:topModel.color];
        self.leftSumLB.textColor=[UIColor colorWithHexString:topModel.color];
        [self.rightBtn setTitle:topModel.tixian_btn forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor colorWithHexString:topModel.tixian_btn_color] forState:UIControlStateNormal];
        self.rightBtn.backgroundColor=[UIColor colorWithHexString:topModel.tixian_btn_bj];
    }
}
-(void)setBottomModel:(FNmerchantIndentModel *)bottomModel{
    _bottomModel=bottomModel;
    if(bottomModel){
        NSString *countStr=bottomModel.counts_str;
        NSString *expenseCountStr=bottomModel.counts;
        NSString *commossionStr=bottomModel.commossion_str;
        NSString *expenseStr=bottomModel.commossion;
        NSString *jointStr=[NSString stringWithFormat:@"%@ %@    %@ %@",countStr,expenseCountStr,commossionStr,expenseStr];
        self.expenseCountLB.text=jointStr;
        if([expenseCountStr kr_isNotEmpty]){
           [self.expenseCountLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:14] changeText:expenseCountStr];
           [self.expenseCountLB fn_changeColorWithTextColor:[UIColor colorWithHexString:bottomModel.counts_color] changeText:expenseCountStr];
        }
        if([expenseStr kr_isNotEmpty]){
            [self.expenseCountLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:14] changeText:expenseStr];
            [self.expenseCountLB fn_changeColorWithTextColor:[UIColor colorWithHexString:bottomModel.commossion_color] changeText:expenseStr];
        }
    }
}
@end
