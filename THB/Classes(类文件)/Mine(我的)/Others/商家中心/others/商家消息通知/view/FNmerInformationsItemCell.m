//
//  FNmerInformationsItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerInformationsItemCell.h"

@implementation FNmerInformationsItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.titleLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.titleLB];
    
    self.msgLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.msgLB];
    
    self.dateLB.font=[UIFont systemFontOfSize:12];
    self.dateLB.textColor=[UIColor whiteColor];
    self.dateLB.textAlignment=NSTextAlignmentCenter;
    self.dateLB.backgroundColor=RGB(204, 205, 206);
    self.dateLB.cornerRadius=5/2;
    
    self.titleLB.font=[UIFont systemFontOfSize:16];
    self.titleLB.textColor=RGB(60, 60, 60);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.msgLB.font=[UIFont systemFontOfSize:12];
    self.msgLB.textColor=RGB(140, 140, 140);
    self.msgLB.textAlignment=NSTextAlignmentLeft;
    self.msgLB.numberOfLines=2;
    
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.cornerRadius=5;
    self.bgView.borderWidth=1;
    self.bgView.clipsToBounds = YES;
    self.bgView.borderColor = RGB(232, 232, 232);
    
    self.dateLB.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, 20).widthIs(150).heightIs(20);
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 15).bottomSpaceToView(self, 0).rightSpaceToView(self, 15).heightIs(87);
    
    self.titleLB.sd_layout
    .topSpaceToView(self.bgView, 18).leftSpaceToView(self.bgView, 20).rightSpaceToView(self.bgView, 20).heightIs(20);
    
    self.msgLB.sd_layout
    .topSpaceToView(self.titleLB, 6).leftSpaceToView(self.bgView, 20).rightSpaceToView(self.bgView, 20).bottomSpaceToView(self.bgView, 5); 
    
}

-(void)setModel:(FNmerInformationsModel *)model{
    _model=model;
    if(model){
        CGFloat pleasedLBW=[model.time kr_getWidthWithTextHeight:20 font:12];
        if(pleasedLBW>150){
            pleasedLBW=150;
        }
        self.dateLB.sd_layout
        .centerXEqualToView(self).topSpaceToView(self, 20).widthIs(pleasedLBW+20).heightIs(20);
        self.dateLB.text=model.time;
        self.titleLB.text=model.title;
        self.msgLB.text=model.msg;
    }
}
@end
