//
//  FNreckDeHeaderView.m
//  THB
//
//  Created by Jimmy on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNreckDeHeaderView.h"

@implementation FNreckDeHeaderView
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.backgroundColor=RGB(246, 245, 245);
    //收入
    self.incomeLB=[UILabel new];
    self.incomeLB.font=kFONT12;
    self.incomeLB.textColor=[UIColor blackColor];
    [self addSubview:self.incomeLB];
    
    //支出
    self.disburseLB=[UILabel new];
    self.disburseLB.font=kFONT12;
    self.disburseLB.textColor=[UIColor blackColor];
    [self addSubview:self.disburseLB];
    
    self.monthImage=[UIImageView new];
    [self addSubview:self.monthImage];
    
    self.monthLB=[UILabel new];
    self.monthLB.font=kFONT12;
    self.monthLB.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.monthLB];
    
    self.incomeLB.sd_layout
    .leftSpaceToView(self, 10).heightIs(20).centerYEqualToView(self).widthIs(80);
    
    self.disburseLB.sd_layout
    .leftSpaceToView(self.incomeLB, 10).heightIs(20).centerYEqualToView(self).widthIs(80);
    
    self.monthImage.sd_layout
    .rightSpaceToView(self, 10).heightIs(15).centerYEqualToView(self).widthIs(15);
    
    self.monthLB.sd_layout
    .rightSpaceToView(self.monthImage, 10).heightIs(20).centerYEqualToView(self);
    [self.monthLB setSingleLineAutoResizeWithMaxWidth:60]; 
    
    
}

-(void)setModel:(FNreckSetDeModel *)model{
    _model=model;
    if(model){
        self.incomeLB.text=model.str;//@"收入 ¥71.24";
        NSArray *array = [model.str componentsSeparatedByString:@" "];
        NSString* strOne =array[0];// @"收入 ";
        NSString* price=array[1];//@"";
        NSString* jointStringOne=[NSString stringWithFormat:@"%@ %@",strOne,price];
        self.incomeLB.text =jointStringOne;
        [self.incomeLB addSingleAttributed:@{NSForegroundColorAttributeName:RGB(255, 0, 0)} ofRange:[self.incomeLB.text rangeOfString:price]];
        
        NSString* strTwo =array[2];// @"收入 ";
        NSString* priceTwo=array[3];//@"";
        NSString* jointStringTwo=[NSString stringWithFormat:@"%@ %@",strTwo,priceTwo];
        self.disburseLB.text=jointStringTwo;//@"支出 ¥71.24";
        [self.disburseLB addSingleAttributed:@{NSForegroundColorAttributeName:RGB(0, 114, 255)} ofRange:[self.disburseLB.text rangeOfString:priceTwo]];
        
        self.monthLB.text=model.time_str;//@"本月";
        self.monthImage.image=IMAGE(@"FJ_moth_img");
        
        CGFloat incomeW=[self getWidthWithText:jointStringOne height:20 font:12];
        self.incomeLB.sd_layout
        .leftSpaceToView(self, 10).heightIs(20).centerYEqualToView(self).widthIs(incomeW);
        
        CGFloat disburseW=[self getWidthWithText:jointStringTwo height:20 font:12];
        self.disburseLB.sd_layout
        .leftSpaceToView(self.incomeLB, 10).heightIs(20).centerYEqualToView(self).widthIs(disburseW);
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
