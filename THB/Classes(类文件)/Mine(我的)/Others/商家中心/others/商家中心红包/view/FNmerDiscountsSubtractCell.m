//
//  FNmerDiscountsSubtractCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDiscountsSubtractCell.h"

@implementation FNmerDiscountsSubtractCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgView=[[UIImageView alloc]init];
    [self addSubview:self.bgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.str1LB=[[UILabel alloc]init];
    [self addSubview:self.str1LB];
    
    self.str2LB=[[UILabel alloc]init];
    [self addSubview:self.str2LB];
    
    self.str3LB=[[UILabel alloc]init];
    [self addSubview:self.str3LB];
    
    self.stateImage=[[UIImageView alloc]init];
    [self addSubview:self.stateImage];
    
    self.amendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.amendBtn];
    
    self.cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.cancelBtn];
    
    self.nameLB.font=[UIFont systemFontOfSize:17];
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.str1LB.font=[UIFont systemFontOfSize:11];
    self.str1LB.textColor=RGB(102, 102, 102);
    self.str1LB.textAlignment=NSTextAlignmentLeft;
    
    self.str2LB.font=[UIFont systemFontOfSize:11];
    self.str2LB.textColor=RGB(102, 102, 102);
    self.str2LB.textAlignment=NSTextAlignmentLeft;
    
    self.str3LB.font=[UIFont systemFontOfSize:11];
    self.str3LB.textColor=RGB(102, 102, 102);
    self.str3LB.textAlignment=NSTextAlignmentLeft;
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 40).rightSpaceToView(self, 100).topSpaceToView(self,23).heightIs(22);
    
    self.str1LB.sd_layout
    .leftSpaceToView(self, 40).rightSpaceToView(self, 100).topSpaceToView(self.nameLB,8).heightIs(13);
    
    self.str2LB.sd_layout
    .leftSpaceToView(self, 40).rightSpaceToView(self, 70).topSpaceToView(self.str1LB,6).heightIs(13);
    
    self.str3LB.sd_layout
    .leftSpaceToView(self, 40).rightSpaceToView(self, 150).topSpaceToView(self.str2LB,6).heightIs(13);
    
    self.stateImage.sd_layout
    .rightSpaceToView(self, 10).topSpaceToView(self, 0).widthIs(85).heightIs(70);
    
    self.amendBtn.sd_layout
    .rightSpaceToView(self, 28).topSpaceToView(self.stateImage, 17).heightIs(24).widthIs(53);
    
    self.cancelBtn.sd_layout
    .rightSpaceToView(self.amendBtn, 11).centerYEqualToView(self.amendBtn).heightIs(24).widthIs(53);
    
   
    [self.amendBtn addTarget:self action:@selector(amendBtnClick)];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick)];
}

-(void)amendBtnClick{
    if ([self.delegate respondsToSelector:@selector(didMerDiscountsSubtractAmendIndex:)]) {
        [self.delegate didMerDiscountsSubtractAmendIndex:self.index];
    }
}
-(void)cancelBtnClick{
    if ([self.delegate respondsToSelector:@selector(didMerDiscountsSubtractStateIndex:)]) {
        [self.delegate didMerDiscountsSubtractStateIndex:self.index];
    }
}
-(void)setModel:(FNmerDiscountsItemModel *)model{
    _model=model;
    if(model){
        self.bgView.image=IMAGE(@"FN_manjianBgimg");
        self.nameLB.text=model.title;
        self.str1LB.text=model.time;
        [self.amendBtn setTitle:@"修改" forState:UIControlStateNormal];
        [self.cancelBtn setTitle:model.status_str forState:UIControlStateNormal];
        
        self.amendBtn.titleLabel.font=kFONT12;
        self.amendBtn.cornerRadius=24/2;
        
        self.cancelBtn.titleLabel.font=kFONT12;
        self.cancelBtn.cornerRadius=24/2;
        self.cancelBtn.borderWidth=1;
        self.cancelBtn.clipsToBounds = YES; 
        if([model.typeZY isEqualToString:@"full_reduction"]){
            self.amendBtn.backgroundColor=RGB(2, 188, 165);
            self.cancelBtn.borderColor = RGB(2, 188, 165);
            [self.cancelBtn setTitleColor:RGB(2, 188, 165) forState:UIControlStateNormal];
            
            self.str2LB.text=model.str1;
            self.str3LB.text=model.str2;
        }
        if([model.typeZY isEqualToString:@"discount"]){
            self.amendBtn.backgroundColor=RGB(255, 76, 74);
            self.cancelBtn.borderColor = RGB(255, 76, 74);
            [self.cancelBtn setTitleColor:RGB(255, 76, 74) forState:UIControlStateNormal];
            
            self.str2LB.text=model.str;
            //self.str3LB.text=model.str2;
        }
        [self.stateImage setUrlImg:model.icon];
        if([model.is_expired integerValue]==0){
            self.amendBtn.hidden=NO;
            self.cancelBtn.hidden=NO;
            self.nameLB.textColor=RGB(51, 51, 51);
            self.str1LB.textColor=RGB(102, 102, 102);
            self.str2LB.textColor=RGB(102, 102, 102);
            self.str3LB.textColor=RGB(102, 102, 102);
        }else{
            self.amendBtn.hidden=YES;
            self.cancelBtn.hidden=YES;
            self.nameLB.textColor=RGB(153, 153, 153);
            self.str1LB.textColor=RGB(153, 153, 153);
            self.str2LB.textColor=RGB(153, 153, 153);
            self.str3LB.textColor=RGB(153, 153, 153);
        } 
    }
}
@end
