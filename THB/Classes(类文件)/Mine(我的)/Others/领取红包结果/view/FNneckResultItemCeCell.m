//
//  FNneckResultItemCeCell.m
//  THB
//
//  Created by Jimmy on 2019/2/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNneckResultItemCeCell.h"

@implementation FNneckResultItemCeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews
{
    self.backgroundColor=[UIColor whiteColor];
    
    self.headImg=[[UIImageView alloc]init];
    //self.headImg.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:self.headImg];
    
    self.nameLB=[[UILabel alloc]init];
    self.nameLB.font=kFONT16;
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.nameLB];
    
    self.sumLB=[[UILabel alloc]init];
    self.sumLB.font=[UIFont systemFontOfSize:12];
    self.sumLB.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.sumLB];
    
    self.dateLB=[[UILabel alloc]init];
    self.dateLB.font=kFONT12;
    self.dateLB.textColor=RGB(25, 25, 25);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.dateLB];
    
    self.remarkLB=[[UILabel alloc]init];
    self.remarkLB.font=kFONT16;
    self.remarkLB.textColor=RGB(25, 25, 25);
    self.remarkLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.remarkLB];
    
    self.pinImg=[[UIImageView alloc]init];
    [self addSubview:self.pinImg];
    
    self.lineView=[[UIView alloc]init];
    self.lineView.backgroundColor=RGB(228, 228, 228);
    [self addSubview:self.lineView];
    
    [self incomposition];
    
}
-(void)incomposition{
    
    CGFloat inter_10=10;
    CGFloat inter_15=15;
    CGFloat inter_20=20;
    
    self.headImg.sd_layout
    .leftSpaceToView(self,inter_20).centerYEqualToView(self).heightIs(45).widthIs(45);
    
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImg,inter_15).topEqualToView(self.headImg).heightIs(15);
    [self.nameLB setSingleLineAutoResizeWithMaxWidth:180];
    
    self.sumLB.sd_layout
    .rightSpaceToView(self, inter_10).topEqualToView(self.headImg).heightIs(15);
    [self.sumLB setSingleLineAutoResizeWithMaxWidth:100];
    
    self.dateLB.sd_layout
    .leftSpaceToView(self.headImg,inter_15).bottomSpaceToView(self, 10).heightIs(15);
    [self.dateLB setSingleLineAutoResizeWithMaxWidth:150];
    
    self.remarkLB.sd_layout
    .rightSpaceToView(self, inter_10).bottomEqualToView(self.headImg).heightIs(15).widthIs(70);
    
    self.pinImg.sd_layout
    .rightSpaceToView(self.remarkLB, inter_15).centerYEqualToView(self.remarkLB).widthIs(10).heightIs(10);
    
    self.lineView.sd_layout
    .leftSpaceToView(self.headImg,inter_15).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(1);
    
}

-(void)setModel:(FNopenRedPacketRecordModel *)model{
    _model=model;
    if(model){
        self.nameLB.text=model.nickname;//@"白云朵朵";
        self.sumLB.text=[NSString stringWithFormat:@"%@ 元",model.money];//@"0.01 元";
        //self.remarkLB.text=@"手气最佳";
        self.dateLB.text=model.time;
        [self.headImg setNoPlaceholderUrlImg:model.head_img];
    }
}
@end
