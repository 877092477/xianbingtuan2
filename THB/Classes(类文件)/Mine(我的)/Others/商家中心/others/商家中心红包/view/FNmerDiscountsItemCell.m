//
//  FNmerDiscountsItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDiscountsItemCell.h"

@implementation FNmerDiscountsItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.sumLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.sumLB];
    
    self.nameLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.nameLB];  
    
    self.str1LB=[[UILabel alloc]init];
    [self.bgView addSubview:self.str1LB];
    
    self.str2LB=[[UILabel alloc]init];
    [self.bgView addSubview:self.str2LB];
    
    self.typeLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.typeLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.dateLB];
    
    self.limit1LB=[[UILabel alloc]init];
    [self.bgView addSubview:self.limit1LB];
    
    self.limit2LB=[[UILabel alloc]init];
    [self.bgView addSubview:self.limit2LB];
    
    self.wearDateLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.wearDateLB];
    
    self.endDateLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.endDateLB];
    
    self.deadlineLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.deadlineLB];
    
    
    self.centreView=[[UIView alloc]init];
    [self.bgView addSubview:self.centreView];
    
    self.amendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.amendBtn];
    
    self.cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.cancelBtn];
    
    self.previewBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.previewBtn];
    
    self.stateImage=[[UIImageView alloc]init];
    [self.bgView addSubview:self.stateImage];
    
    self.sumLB.font=[UIFont systemFontOfSize:18];
    self.sumLB.textColor=RGB(255, 68, 68);
    self.sumLB.textAlignment=NSTextAlignmentCenter;
    self.sumLB.numberOfLines=2;
    
    self.nameLB.font=[UIFont systemFontOfSize:16];
    self.nameLB.textColor=RGB(24, 24, 24);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.str1LB.font=[UIFont systemFontOfSize:11];
    self.str1LB.textColor=RGB(140, 140, 140);
    self.str1LB.textAlignment=NSTextAlignmentLeft;
    
    self.str2LB.font=[UIFont systemFontOfSize:11];
    self.str2LB.textColor=RGB(140, 140, 140);
    self.str2LB.textAlignment=NSTextAlignmentLeft;
    
    self.typeLB.font=[UIFont systemFontOfSize:11];
    self.typeLB.textColor=RGB(140, 140, 140);
    self.typeLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:11];
    self.dateLB.textColor=RGB(140, 140, 140);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.limit1LB.font=[UIFont systemFontOfSize:11];
    self.limit1LB.textColor=RGB(140, 140, 140);
    self.limit1LB.textAlignment=NSTextAlignmentLeft;
    
    self.limit2LB.font=[UIFont systemFontOfSize:11];
    self.limit2LB.textColor=RGB(140, 140, 140);
    self.limit2LB.textAlignment=NSTextAlignmentLeft;
    
    self.wearDateLB.font=[UIFont systemFontOfSize:11];
    self.wearDateLB.textColor=RGB(140, 140, 140);
    self.wearDateLB.textAlignment=NSTextAlignmentLeft;
    
    self.endDateLB.font=[UIFont systemFontOfSize:11];
    self.endDateLB.textColor=RGB(140, 140, 140);
    self.endDateLB.textAlignment=NSTextAlignmentLeft;
    
    self.deadlineLB.font=[UIFont systemFontOfSize:11];
    self.deadlineLB.textColor=RGB(140, 140, 140);
    self.deadlineLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgView.cornerRadius=5;
    self.bgView.backgroundColor=[UIColor whiteColor];
    
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.sumLB.sd_layout
    .leftSpaceToView(self.bgView, 0).widthIs(95).heightIs(90).centerYEqualToView(self.bgView);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.bgView,18).heightIs(20);
    
    self.str1LB.sd_layout
    .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.nameLB,6).heightIs(15);  
    
    self.str2LB.sd_layout
    .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.str1LB,1).heightIs(15);
    
    self.typeLB.sd_layout
   .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.str2LB,6).heightIs(15);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.str2LB,1).heightIs(15);
    
    self.limit1LB.sd_layout
    .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.dateLB,1).heightIs(15);
    
    self.limit2LB.sd_layout
    .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.limit1LB,1).heightIs(15);
    
    self.centreView.sd_layout
    .centerYEqualToView(self.bgView).widthIs(50).heightIs(1).rightSpaceToView(self.bgView, 0);
    
    self.amendBtn.sd_layout
    .rightSpaceToView(self.bgView, 15).topSpaceToView(self.bgView, 76).heightIs(25).widthIs(55);
    
    self.cancelBtn.sd_layout
    .rightSpaceToView(self.bgView, 15).topSpaceToView(self.amendBtn, 8).heightIs(25).widthIs(55);
    
    self.stateImage.sd_layout
    .rightSpaceToView(self.bgView, 0).topEqualToView(self.bgView).widthIs(85).heightIs(69);
    
    self.previewBtn.sd_layout
    .centerXEqualToView(self.bgView).widthIs(30).heightIs(20).bottomSpaceToView(self.bgView, 5);
    
    self.previewBtn.imageView.sd_layout
    .centerXEqualToView(self.previewBtn).centerYEqualToView(self.previewBtn).widthIs(10).heightIs(9);
    
    self.wearDateLB.sd_layout
    .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.limit2LB,6).heightIs(15);
    
    self.endDateLB.sd_layout
    .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.wearDateLB,1).heightIs(15);
    
    self.deadlineLB.sd_layout
    .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.endDateLB,1).heightIs(15);
    
    
    [self.previewBtn addTarget:self action:@selector(previewBtnClick)];
    [self.amendBtn addTarget:self action:@selector(amendBtnClick)];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick)];
}
-(void)previewBtnClick{
    if ([self.delegate respondsToSelector:@selector(didMerDiscountsRefreshIndex:)]) {
        [self.delegate didMerDiscountsRefreshIndex:self.index];
    }
}
-(void)amendBtnClick{
    if ([self.delegate respondsToSelector:@selector(didMerDiscountsAmendIndex:)]) {
        [self.delegate didMerDiscountsAmendIndex:self.index];
    }
}
-(void)cancelBtnClick{
    if ([self.delegate respondsToSelector:@selector(didMerDiscountsStateIndex:)]) {
        [self.delegate didMerDiscountsStateIndex:self.index];
    }
}
-(void)setModel:(FNmerDiscountsItemModel *)model{
    _model=model;
    if(model){
        NSString *sumJoint=[NSString stringWithFormat:@"¥%@",model.price];
        self.sumLB.text=sumJoint;
        if([model.price kr_isNotEmpty]){
           [self.sumLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:35] changeText:model.price];
        }
        self.nameLB.text=model.name;
        self.str1LB.text=[NSString stringWithFormat:@"%@  %@",model.str1,model.str2];
        if([model.str3 kr_isNotEmpty] && [model.str4 kr_isNotEmpty]){
           self.str2LB.text=[NSString stringWithFormat:@"%@  %@",model.str3,model.str4];
        }
        self.typeLB.text=[NSString stringWithFormat:@"  %@",model.str5];
        self.dateLB.text=model.str6;
        self.limit1LB.text=model.str7;
        self.limit2LB.text=model.str8;
        self.wearDateLB.text=model.str10;
        self.endDateLB.text=model.str11;
        self.deadlineLB.text=model.str12;
        if(model.rowHeight>175){
            self.wearDateLB.hidden=NO;
            self.endDateLB.hidden=NO;
            self.deadlineLB.hidden=NO;
            self.previewBtn.hidden=YES;
        }else{
            self.wearDateLB.hidden=YES;
            self.endDateLB.hidden=YES;
            self.deadlineLB.hidden=YES;
            self.previewBtn.hidden=NO;
        }
        [self.previewBtn setImage:IMAGE(@"FN_xbMoreimg") forState:UIControlStateNormal];
        [self.amendBtn setTitle:@"修改" forState:UIControlStateNormal];
        [self.cancelBtn setTitle:model.status_str forState:UIControlStateNormal];
        
        self.amendBtn.titleLabel.font=kFONT12;
        self.amendBtn.cornerRadius=25/2;
        
        self.cancelBtn.titleLabel.font=kFONT12;
        self.cancelBtn.cornerRadius=25/2;
        self.cancelBtn.borderWidth=1;
        self.cancelBtn.clipsToBounds = YES;
        
        [self setPlaceReload:model.typeStr];
        
        //[self.stateImage setUrlImg:model.guoqi_icon];
        [self.stateImage setUrlImg:model.icon];
        if([model.typeStr isEqualToString:@"red_packet"]){
            self.sumLB.textColor=RGB(255, 68, 68);
            self.amendBtn.backgroundColor=RGB(255, 68, 68);
            self.cancelBtn.borderColor = RGB(255, 68, 68);
            [self.cancelBtn setTitleColor:RGB(255, 68, 68) forState:UIControlStateNormal]; 
        }
        if([model.typeStr isEqualToString:@"yhq"]){
            self.sumLB.textColor=RGB(255, 114, 0);
            self.amendBtn.backgroundColor=RGB(255, 68, 68);
            self.cancelBtn.borderColor = RGB(255, 76, 74);
            [self.cancelBtn setTitleColor:RGB(255, 76, 74) forState:UIControlStateNormal];
        }
        
        if([model.is_expired integerValue]==0){
            self.amendBtn.hidden=NO;
            self.cancelBtn.hidden=NO;
            self.nameLB.textColor=RGB(24, 24, 24);
            self.str1LB.textColor=RGB(140, 140, 140);
            self.str2LB.textColor=RGB(140, 140, 140);
            self.sumLB.textColor=RGB(140, 140, 140);
        }else{
            self.amendBtn.hidden=YES;
            self.cancelBtn.hidden=YES;
            self.nameLB.textColor=RGB(153, 153, 153);
            self.str1LB.textColor=RGB(140, 140, 140);
            self.str2LB.textColor=RGB(140, 140, 140);
            self.sumLB.textColor=RGB(153, 153, 153);
        }
    }
}

-(void)setPlaceReload:(NSString*)type{
    if([type isEqualToString:@"red_packet"]){
        self.typeLB.hidden=NO;
        self.dateLB.sd_layout
        .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.typeLB,1).heightIs(15);
        
        self.limit1LB.sd_layout
        .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.dateLB,1).heightIs(15);
        
        self.limit2LB.sd_layout
        .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.limit1LB,1).heightIs(15);
        
        self.stateImage.sd_layout
        .rightSpaceToView(self.bgView, 0).topEqualToView(self.bgView).widthIs(85).heightIs(69);
        
        self.previewBtn.sd_layout
        .centerXEqualToView(self.bgView).widthIs(30).heightIs(20).bottomSpaceToView(self.bgView, 5);
        
        self.previewBtn.imageView.sd_layout
        .centerXEqualToView(self.previewBtn).centerYEqualToView(self.previewBtn).widthIs(10).heightIs(9);
        
        self.wearDateLB.sd_layout
        .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.limit2LB,6).heightIs(15);
        
        self.endDateLB.sd_layout
        .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.wearDateLB,1).heightIs(15);
        
        self.deadlineLB.sd_layout
        .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.endDateLB,1).heightIs(15);
    }else{
        self.typeLB.hidden=YES;
        self.dateLB.sd_layout
        .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.str2LB,6).heightIs(15);
        
        self.limit1LB.sd_layout
        .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.dateLB,1).heightIs(15);
        
        self.limit2LB.sd_layout
        .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.limit1LB,1).heightIs(15);
        
        self.stateImage.sd_layout
        .rightSpaceToView(self.bgView, 0).topEqualToView(self.bgView).widthIs(85).heightIs(69);
        
        self.previewBtn.sd_layout
        .centerXEqualToView(self.bgView).widthIs(30).heightIs(20).bottomSpaceToView(self.bgView, 5);
        
        self.previewBtn.imageView.sd_layout
        .centerXEqualToView(self.previewBtn).centerYEqualToView(self.previewBtn).widthIs(10).heightIs(9);
        
        self.wearDateLB.sd_layout
        .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.limit2LB,6).heightIs(15);
        
        self.endDateLB.sd_layout
        .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.wearDateLB,1).heightIs(15);
        
        self.deadlineLB.sd_layout
        .leftSpaceToView(self.bgView, 95).rightSpaceToView(self.bgView, 70).topSpaceToView(self.endDateLB,1).heightIs(15);
    }
}
@end
