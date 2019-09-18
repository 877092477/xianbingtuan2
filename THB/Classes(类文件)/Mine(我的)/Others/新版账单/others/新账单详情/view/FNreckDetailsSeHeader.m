//
//  FNreckDetailsSeHeader.m
//  THB
//
//  Created by Jimmy on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNreckDetailsSeHeader.h"

@implementation FNreckDetailsSeHeader
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.backgroundColor=[UIColor whiteColor];//RGB(246, 245, 245);
    
    self.line=[[UIView alloc]init];
    //self.line.backgroundColor=RGB(140,140,140);
    [self addSubview:self.line];
    
    self.typeImage=[UIImageView new];
    //self.typeImage.backgroundColor=RGB(246, 245, 245);
    [self addSubview:self.typeImage];
    
    self.typeLB=[UILabel new];
    self.typeLB.font=kFONT16;
    [self addSubview:self.typeLB]; 
   
    self.awardLB=[UILabel new];
    self.awardLB.font=kFONT17;
    self.awardLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.awardLB];
    
    self.stateLB=[UILabel new];
    self.stateLB.font=kFONT13;
    self.stateLB.textColor=RGB(140,140,140);
    self.stateLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.stateLB];
    
    [self incompositionFrames];
}
-(void)incompositionFrames{
    CGFloat inter_20=20;
    CGFloat inter_10=10;
    CGFloat inter_5=5;
    self.line.sd_layout
    .heightIs(20).widthIs(1).topSpaceToView(self, inter_20).centerXEqualToView(self);
    
    self.typeImage.sd_layout
    .rightSpaceToView(self.line, inter_5).heightIs(20).widthIs(20).topSpaceToView(self, 15);
    
    self.typeLB.sd_layout
    .leftSpaceToView(self.line, inter_5).heightIs(20).centerYEqualToView(self.typeImage);
    [self.typeLB setSingleLineAutoResizeWithMaxWidth:150];
    
    self.awardLB.sd_layout
    .topSpaceToView(self.typeImage, inter_20).centerXEqualToView(self).heightIs(25);
    [self.awardLB setSingleLineAutoResizeWithMaxWidth:200];
    
    self.stateLB.sd_layout
    .bottomSpaceToView(self, inter_10).centerXEqualToView(self).heightIs(20);
    [self.stateLB setSingleLineAutoResizeWithMaxWidth:200];
    
    
    
    
}
-(void)setModel:(FNreckDetailsSeModel *)model{
    _model=model;
    if(model){
        
        [self.typeImage setUrlImg:model.img];
        self.typeLB.text=model.str;//@"京东";
        self.awardLB.text=model.str;//@"自购奖励 +5.74";
        self.stateLB.text=model.str1;//@"交易完成";
        
        NSString* coupon = model.type_str;//@"自购奖励 ";
        NSString* price = [NSString stringWithFormat:@"%@",model.interal];//@"+5.74";
        self.awardLB.text =[NSString stringWithFormat:@"%@  %@",coupon,price];
        [self.awardLB addSingleAttributed:@{NSForegroundColorAttributeName:RGB(250, 90, 0)} ofRange:[self.awardLB.text rangeOfString:price]];
    }
}
@end
