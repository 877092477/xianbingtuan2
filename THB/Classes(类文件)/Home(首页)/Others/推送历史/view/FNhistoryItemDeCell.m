//
//  FNhistoryItemDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/21.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//95
#import "FNhistoryItemDeCell.h"

@implementation FNhistoryItemDeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews{
    
    self.backgroundColor=RGB(245, 245, 245);
    
    self.timeLB=[UILabel new];
    self.timeLB.textColor=[UIColor whiteColor];
    self.timeLB.backgroundColor=RGB(223, 223, 223);
    self.timeLB.font=kFONT12;
    self.timeLB.textAlignment=NSTextAlignmentCenter;
    self.timeLB.cornerRadius=5;
    [self addSubview:self.timeLB];
    
    self.bgView=[[UIView alloc]init];
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.cornerRadius=5;
    [self addSubview:self.bgView];
    
    self.textLB=[UILabel new];
    self.textLB.textColor=RGB(24, 24, 24);
    self.textLB.font=kFONT14;
    self.textLB.numberOfLines=0;
    self.textLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.textLB];
    
    //self.line=[[UIView alloc]init];
    //self.line.backgroundColor=[UIColor whiteColor];
    //[self addSubview:self.line];
    
    self.contentLB=[UILabel new];
    self.contentLB.textColor=RGB(140, 140, 140);
    self.contentLB.font=kFONT12;
    self.contentLB.numberOfLines=0;
    self.contentLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.contentLB];
    
    [self inAppointFrames];
    
}
-(void)inAppointFrames{
    
    CGFloat inter_10=10;
    
    self.timeLB.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, inter_10).widthIs(150).heightIs(25);
    
    self.bgView.sd_layout
    .bottomSpaceToView(self, inter_10).topSpaceToView(self.timeLB, inter_10).rightSpaceToView(self, inter_10).leftSpaceToView(self, inter_10);
    
    self.textLB.sd_layout
    .topSpaceToView(self.bgView, inter_10).rightSpaceToView(self.bgView, inter_10).leftSpaceToView(self.bgView, inter_10).autoHeightRatio(0);
    
    self.contentLB.sd_layout
    .bottomSpaceToView(self.bgView, inter_10).rightSpaceToView(self.bgView, inter_10).leftSpaceToView(self.bgView, inter_10).autoHeightRatio(0);
    
}
-(void)setModel:(FNhistoryItemModel *)model{
    _model=model;
    if(model){
        self.timeLB.text=model.time;
        self.textLB.text=model.title;
        self.contentLB.text=model.msg;
    }
}
@end
