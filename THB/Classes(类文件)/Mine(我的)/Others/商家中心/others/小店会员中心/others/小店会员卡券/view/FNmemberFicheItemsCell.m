//
//  FNmemberFicheItemsCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmemberFicheItemsCell.h"

@implementation FNmemberFicheItemsCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
   
    self.sumLB=[[UILabel alloc]init];
    [self addSubview:self.sumLB];
    
    self.sumHintLB=[[UILabel alloc]init];
    [self addSubview:self.sumHintLB];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.employBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.employBtn];
    
    self.sumLB.font=[UIFont systemFontOfSize:12 weight:2];
    self.sumLB.textColor=RGB(255, 58, 58);
    self.sumLB.textAlignment=NSTextAlignmentCenter;
    
    self.sumHintLB.font=[UIFont systemFontOfSize:11];
    self.sumHintLB.textColor=RGB(140, 140, 140);
    self.sumHintLB.textAlignment=NSTextAlignmentCenter;
    
    self.nameLB.font=[UIFont systemFontOfSize:15 weight:2];
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.numberOfLines=2;
    self.hintLB.font=[UIFont systemFontOfSize:11];
    self.hintLB.textColor=RGB(140, 140, 140);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:11];
    self.dateLB.textColor=RGB(140, 140, 140);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.sumLB.sd_layout
    .leftSpaceToView(self, 5).topSpaceToView(self, 35).widthIs(90).heightIs(20);
    
    self.sumHintLB.sd_layout
    .leftSpaceToView(self, 5).topSpaceToView(self.sumLB, 3).widthIs(90).heightIs(15);
    
    self.employBtn.sd_layout
    .centerYEqualToView(self).rightSpaceToView(self, 10).widthIs(55).heightIs(24);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.sumLB, 10).rightSpaceToView(self.employBtn, 15).topSpaceToView(self, 18).heightIs(20);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self.sumLB, 10).rightSpaceToView(self.employBtn, 15).topSpaceToView(self.nameLB, 3).heightIs(15);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self.sumLB, 10).rightSpaceToView(self.employBtn, 15).topSpaceToView(self.dateLB, 1).heightIs(30);
    [self.employBtn addTarget:self action:@selector(employBtnClick)];
}
-(void)employBtnClick{
    if ([self.delegate respondsToSelector:@selector(inMarketBerFicheItemswithIndex:)]) {
        [self.delegate inMarketBerFicheItemswithIndex:self.index];
    }
}
-(void)setModel:(FNmeFicheItemisModel *)model{
    _model=model;
    if(model){
        self.sumLB.text=[NSString stringWithFormat:@"¥%@",model.money];
        if([model.money kr_isNotEmpty]){
           [self.sumLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:15 weight:2] changeText:model.money];
        }
        self.sumHintLB.text=model.tips;
        self.nameLB.text=model.name;
        //self.nameLB.text=[NSString stringWithFormat:@"%@%@",model.store_name,model.name];
        self.dateLB.text=model.str;
        self.hintLB.text=[NSString stringWithFormat:@"%@  %@",model.str1,model.str3];
        
        [self.employBtn setTitle:@"使用" forState:UIControlStateNormal];
        [self.employBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.employBtn.titleLabel.font=kFONT13;
        self.employBtn.backgroundColor=RGB(255, 58, 58);
        self.employBtn.cornerRadius=24/2;
    }
}
@end
