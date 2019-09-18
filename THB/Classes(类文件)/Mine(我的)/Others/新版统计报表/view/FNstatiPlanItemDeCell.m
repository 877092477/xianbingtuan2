//
//  FNstatiPlanItemDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//预估cell 70
#import "FNstatiPlanItemDeCell.h"

@implementation FNstatiPlanItemDeCell
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.backgroundColor=[UIColor whiteColor];
    
    self.titleLB=[UILabel new];
    self.titleLB.font=kFONT12;
    self.titleLB.textColor=RGB(200,200,200);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLB];
    
    self.sumLB=[UILabel new];
    self.sumLB.font=[UIFont systemFontOfSize:16];
    self.sumLB.textAlignment=NSTextAlignmentLeft;
    self.sumLB.textColor=[UIColor blackColor];
    [self.contentView addSubview:self.sumLB];
    
    self.stateLB=[UILabel new];
    self.stateLB.font=kFONT12;
    self.stateLB.textColor=RGB(102,163,255);
    self.stateLB.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.stateLB];
    
    [self incompositionFrames];
}
-(void)incompositionFrames{
    CGFloat inter_50=50;
    CGFloat inter_5=5;
   
//    self.titleLB.sd_layout
//    .heightIs(15).topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, inter_50).widthIs(100);
//
//    self.sumLB.sd_layout
//    .heightIs(20).leftSpaceToView(self.contentView, inter_50).centerYEqualToView(self.contentView).widthIs(100);
//
//    self.stateLB.sd_layout
//    .heightIs(15).leftSpaceToView(self.contentView, inter_50).topSpaceToView(self.sumLB, inter_5).widthIs(100);
   
    //self.titleLB.text=@"上月预估收入(元)";
    //self.sumLB.text=@"290.00";
    //self.stateLB.text=@"已结算";
}

-(void)setModel:(FNstatisticsCommissionModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.str;
        self.sumLB.text=model.val;
        self.stateLB.text=model.str2;
        self.titleLB.textColor=[UIColor colorWithHexString:model.str_color];
        self.sumLB.textColor=[UIColor colorWithHexString:model.val_color];
        self.stateLB.textColor=[UIColor colorWithHexString:model.str2_color];
        
        NSInteger valueKey = model.place ;//% (2);
        CGFloat titleLBW=[self getWidthWithText:self.titleLB.text height:15 font:12];
        CGFloat inter_35=35;
        CGFloat inter_5=5;
        if (titleLBW<95) {
            titleLBW=95;
        }
        //XYLog(@"valueKey=:%ld",(long)valueKey);
        CGFloat with=FNDeviceWidth/2;
        CGFloat hight=70;
        if(valueKey==0){
            self.titleLB.sd_layout
            .heightIs(15).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, inter_35).widthIs(titleLBW);
            
            self.sumLB.sd_layout
            .heightIs(20).rightSpaceToView(self.contentView, inter_35).centerYEqualToView(self.contentView).widthIs(titleLBW);

            self.stateLB.sd_layout
            .heightIs(15).rightSpaceToView(self.contentView, inter_35).topSpaceToView(self.sumLB, inter_5).widthIs(titleLBW);
            
            
            
            self.titleLB.frame=CGRectMake(inter_35, 0, titleLBW, 15);
            self.sumLB.frame=CGRectMake(inter_35, hight/2-7.5, titleLBW, 20);
            self.stateLB.frame=CGRectMake(inter_35, hight-15, titleLBW, 15);
            
        }else{
            self.titleLB.sd_layout
            .heightIs(15).topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, inter_35).widthIs(titleLBW);
            
            self.sumLB.sd_layout
            .heightIs(20).leftSpaceToView(self.contentView, inter_35).centerYEqualToView(self.contentView).widthIs(titleLBW);
            
            self.stateLB.sd_layout
            .heightIs(15).leftSpaceToView(self.contentView, inter_35).topSpaceToView(self.sumLB, inter_5).widthIs(titleLBW);
            
            
            //[self.titleLB updateLayout];
            //[self.sumLB updateLayout];
            //[self.stateLB updateLayout];
            
            
            self.titleLB.frame=CGRectMake(with-inter_35-titleLBW, 0, titleLBW, 15);
            self.sumLB.frame=CGRectMake(with-inter_35-titleLBW, hight/2-7.5, titleLBW, 20);
            self.stateLB.frame=CGRectMake(with-inter_35-titleLBW, hight-15, titleLBW, 15);
        }
        
        [self.contentView updateLayout];
        
    }
} 

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
@end
