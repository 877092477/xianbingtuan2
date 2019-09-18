//
//  FNneckTwoBagAeCell.m
//  THB
//
//  Created by Jimmy on 2019/2/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNneckTwoBagAeCell.h"

@implementation FNneckTwoBagAeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews
{
    
    self.bgImg=[[UIImageView alloc]init];
    [self addSubview:self.bgImg];
    
    self.headImg=[[UIImageView alloc]init];
    self.headImg.backgroundColor=[UIColor whiteColor];
    self.headImg.cornerRadius=4;
    [self addSubview:self.headImg];
    
    self.nameLB=[[UILabel alloc]init];
    self.nameLB.font=[UIFont systemFontOfSize:20];
    self.nameLB.textColor=[UIColor whiteColor];
    self.nameLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.nameLB];
    
    self.pinImg=[[UIImageView alloc]init];
    //self.pinImg.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:self.pinImg];
    
    self.remarkLB=[[UILabel alloc]init];
    self.remarkLB.font=[UIFont systemFontOfSize:15];
    self.remarkLB.textColor=[UIColor whiteColor];
    self.remarkLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.remarkLB];
    
    self.sumLB=[[UILabel alloc]init];
    self.sumLB.font=[UIFont systemFontOfSize:50];
    self.sumLB.textAlignment=NSTextAlignmentCenter;
    self.sumLB.textColor=[UIColor whiteColor];
    [self addSubview:self.sumLB];
    
    self.reminderLB=[[UILabel alloc]init];
    self.reminderLB.font=[UIFont systemFontOfSize:17];
    self.reminderLB.textAlignment=NSTextAlignmentLeft;
    self.reminderLB.textColor=RGB(116, 116, 116);
    [self addSubview:self.reminderLB];
    
    self.hintLB=[[UILabel alloc]init];
    self.hintLB.font=[UIFont systemFontOfSize:17];
    self.hintLB.textAlignment=NSTextAlignmentCenter;
    self.hintLB.textColor=[UIColor whiteColor];
    [self addSubview:self.hintLB];
    
    self.line=[[UIView alloc]init];
    self.line.backgroundColor=RGB(228, 228, 228);
    [self addSubview:self.line];
    
    [self incomposition];
    
}
-(void)incomposition{
    CGFloat inter_5=5;
    CGFloat inter_15=15;
    CGFloat inter_20=20;
    
    
    self.bgImg.sd_layout
    .leftSpaceToView(self,0).rightSpaceToView(self,0).topSpaceToView(self, 0).heightIs(380); 
    
    self.nameLB.sd_layout
    .topSpaceToView(self, 115).centerXEqualToView(self).heightIs(20).widthIs(150);
    
    self.headImg.sd_layout
    .rightSpaceToView(self.nameLB,5).centerYEqualToView(self.nameLB).widthIs(25).heightIs(25);
    
    self.pinImg.sd_layout
    .leftSpaceToView(self.nameLB, 10).centerYEqualToView(self.nameLB).widthIs(15).heightIs(15);
    
    self.remarkLB.sd_layout
    .leftSpaceToView(self, inter_20).rightSpaceToView(self, inter_20).topSpaceToView(self, 160).heightIs(15);
    
    self.sumLB.sd_layout
    .leftSpaceToView(self, inter_20).rightSpaceToView(self, inter_20).topSpaceToView(self.remarkLB,30 ).heightIs(55); 
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self.sumLB, 25).heightIs(20);
    
    self.reminderLB.sd_layout
    .leftSpaceToView(self, inter_20).rightSpaceToView(self, inter_20).bottomSpaceToView(self, 20).heightIs(20);
    
    self.line.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(1);
}


- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}

-(void)setModel:(FNopenRedPacketDeModel *)model{
    _model=model;
    if(model){
        self.bgImg.image=IMAGE(@"FN_XJ_hb_img");
        [self.headImg setNoPlaceholderUrlImg:model.send_hb_user_head_img];
        self.nameLB.text=model.send_hb_user_nickname;//@"白云朵朵";
        self.remarkLB.text=model.info;//@"恭喜发财，大吉大利";
        self.reminderLB.text=model.str2;//@"1个红包，共120元";
        self.hintLB.text=model.str1;//@"已存入余额, 可直接提款";
        NSString *moneyStr=@" ";
        CGFloat moneyFloat=[model.money floatValue];
        if(moneyFloat>0){
           moneyStr=[NSString stringWithFormat:@"¥%@",model.money];
        }
        self.sumLB.text=moneyStr;
        CGFloat nameLBW=[self getWidthWithText:self.nameLB.text height:20 font:20];
        if (nameLBW>130){
            nameLBW=130;
        }
        self.nameLB.sd_layout
        .topSpaceToView(self, 115).centerXEqualToView(self).heightIs(20).widthIs(nameLBW);
        self.headImg.sd_layout
        .rightSpaceToView(self.nameLB,10).centerYEqualToView(self.nameLB).widthIs(25).heightIs(25);
        self.pinImg.sd_layout
        .leftSpaceToView(self.nameLB, 10).centerYEqualToView(self.nameLB).widthIs(15).heightIs(15);
    }
}
@end
