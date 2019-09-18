//
//  FNmerMemberOrderItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerMemberOrderItemCell.h"

@implementation FNmerMemberOrderItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.timeLB=[[UILabel alloc]init];
    [self addSubview:self.timeLB];
    
    self.stateLB=[[UILabel alloc]init];
    [self addSubview:self.stateLB];
    
    self.evaluateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.evaluateBtn];
    
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.cornerRadius=5;
    self.imgView.cornerRadius=2;
    
    self.nameLB.font=[UIFont systemFontOfSize:16];
    self.nameLB.textColor=RGB(24, 24, 24);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.timeLB.font=[UIFont systemFontOfSize:11];
    self.timeLB.textColor=RGB(140, 140, 140);
    self.timeLB.textAlignment=NSTextAlignmentLeft;
    
    self.stateLB.font=[UIFont systemFontOfSize:12];
    self.stateLB.textColor=RGB(255, 155, 48);
    self.stateLB.textAlignment=NSTextAlignmentRight;
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self, 1).bottomSpaceToView(self, 0);
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 20).centerYEqualToView(self).widthIs(31).heightIs(31);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.imgView, 15).topSpaceToView(self, 18).rightSpaceToView(self, 140).heightIs(17);
    
    self.timeLB.sd_layout
    .leftEqualToView(self.nameLB).topSpaceToView(self.nameLB, 2).heightIs(15).rightEqualToView(self.nameLB);
    
    self.stateLB.sd_layout
    .rightSpaceToView(self, 75).centerYEqualToView(self).heightIs(16).widthIs(45);
    
    self.evaluateBtn.sd_layout
    .rightSpaceToView(self, 20).widthIs(50).heightIs(25).centerYEqualToView(self);
    [self.evaluateBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal]; 
    self.evaluateBtn.titleLabel.font=kFONT12;
    
}
-(void)setModel:(FNmerMembersOrderItemModel *)model{
    _model=model;
    if(model){
        self.nameLB.text=model.title;
        self.timeLB.text=model.time;
        self.stateLB.text=model.status;
        self.nameLB.textColor=[UIColor colorWithHexString:model.title_color];
        self.timeLB.textColor=[UIColor colorWithHexString:model.time_color];
        self.stateLB.textColor=[UIColor colorWithHexString:model.status_color];
        [self.imgView setUrlImg:model.img];
        
        if([model.status isEqualToString:@"已使用"]){
            self.stateLB.sd_resetLayout
            .rightSpaceToView(self, 75).centerYEqualToView(self).heightIs(16).widthIs(45);
            
            self.evaluateBtn.sd_resetLayout
            .rightSpaceToView(self, 20).widthIs(50).heightIs(25).centerYEqualToView(self);
            self.evaluateBtn.hidden=NO;
            [self.evaluateBtn setTitle:@"评价" forState:UIControlStateNormal];
            self.evaluateBtn.borderWidth=1;
            self.evaluateBtn.borderColor = RGB(246, 245, 245);
            self.evaluateBtn.cornerRadius=25/2;
        }else{
            self.stateLB.sd_resetLayout
            .rightSpaceToView(self, 29).centerYEqualToView(self).heightIs(16).widthIs(45);
            
            self.evaluateBtn.sd_resetLayout
            .rightSpaceToView(self, 29).widthIs(0).heightIs(25).centerYEqualToView(self);
            self.evaluateBtn.hidden=YES; 
        }
    }
}
@end
