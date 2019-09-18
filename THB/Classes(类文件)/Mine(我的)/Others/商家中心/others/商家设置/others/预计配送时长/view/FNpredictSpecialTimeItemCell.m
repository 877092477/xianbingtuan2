//
//  FNpredictSpecialTimeItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNpredictSpecialTimeItemCell.h"

@implementation FNpredictSpecialTimeItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.dateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.dateBtn];
    
    self.deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.deleteBtn];
    
    self.compileView=[[UIView alloc]init];
    [self addSubview:self.compileView];
    
    self.hintLB=[[UILabel alloc]init];
    [self.compileView addSubview:self.hintLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=RGB(153, 153, 153);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:12];
    self.hintLB.textColor=RGB(51, 51, 51);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).rightSpaceToView(self, 15).topSpaceToView(self, 7).heightIs(16);
    
    self.dateBtn.sd_layout
    .leftSpaceToView(self, 15).widthIs(106).topSpaceToView(self, 31).heightIs(28);
    
    self.compileView.sd_layout
    .leftSpaceToView( self.dateBtn, 12).widthIs(106).topSpaceToView(self, 31).heightIs(28);
    
    self.deleteBtn.sd_layout
    .rightSpaceToView(self, 10).topSpaceToView(self, 31).heightIs(28).widthIs(50);
    self.deleteBtn.imageView.sd_layout
    .leftSpaceToView(self.deleteBtn, 0).widthIs(15).heightIs(15).centerYEqualToView(self.deleteBtn);
    self.deleteBtn.titleLabel.sd_layout
    .leftSpaceToView(self.deleteBtn, 22).rightSpaceToView(self.deleteBtn, 0).heightIs(16).centerYEqualToView(self.deleteBtn);
    
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(5, 2, 55, 24)]; 
    self.compileField.font = kFONT12;
    self.compileField.keyboardType = UIKeyboardTypeDecimalPad;
    self.compileField.delegate=self;
    self.compileField.textColor=RGB(102, 102, 102);
    self.compileField.textAlignment=NSTextAlignmentCenter;
    [self.compileView addSubview:self.compileField];
    
    self.compileField.sd_layout
    .leftSpaceToView(self.compileView, 5).rightSpaceToView(self.compileView, 35).bottomSpaceToView(self.compileView, 2).heightIs(24);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self.compileField, 2).rightSpaceToView(self.compileView, 5).bottomSpaceToView(self.compileView, 2).heightIs(24);
    
    self.dateBtn.borderWidth=1;
    self.dateBtn.borderColor = RGB(204, 204, 204);
    self.dateBtn.cornerRadius=5;
    self.dateBtn.clipsToBounds = YES;
    self.compileView.borderWidth=1;
    self.compileView.borderColor = RGB(204, 204, 204);
    self.compileView.cornerRadius=5;
    self.compileView.clipsToBounds = YES;
    [self.dateBtn addTarget:self action:@selector(dateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.dateBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.dateBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.deleteBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    
} 
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(didpredictSpecialTimeAction:withContent:)]) {
        [self.delegate didpredictSpecialTimeAction:self.index withContent:textField.text];
    }
}
-(void)dateBtnAction{ 
    if ([self.delegate respondsToSelector:@selector(didpredictSpecialTimeSeletedSDateAction:)]) {
        [self.delegate didpredictSpecialTimeSeletedSDateAction:self.index];
    }
}
-(void)deleteBtnAction{
    if ([self.delegate respondsToSelector:@selector(didpredictSpecialTimeDeleteAction:)]) {
        [self.delegate didpredictSpecialTimeDeleteAction:self.index];
    }
}
-(void)setModel:(FNpredictSpecialTimeModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.title;
        self.hintLB.text=model.durationHint;
        self.compileField.placeholder=model.durationPlaceholder;
        self.compileField.text=model.time;
       
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn setImage:IMAGE(@"details_cion_reduce") forState:UIControlStateNormal];
        
        if([model.start_time kr_isNotEmpty] && [model.end_time kr_isNotEmpty]){
           [self.dateBtn setTitle:[NSString stringWithFormat:@"%@ 至 %@",model.start_time,model.end_time] forState:UIControlStateNormal];
           [self.dateBtn.titleLabel fn_changeColorWithTextColor:RGB(51, 51, 51) changeTexts:@[model.start_time,model.end_time]];
        }else{
           [self.dateBtn setTitle:[NSString stringWithFormat:@"%@ 至 %@",model.startDateHint,model.endDateHint] forState:UIControlStateNormal];
            [self.dateBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        }
    }
}
-(void)setIndex:(NSIndexPath *)index{
    _index=index;
    if(index){
        self.titleLB.text=[NSString stringWithFormat:@"%@%ld",self.model.title,(long)index.row];
    }
}
@end
