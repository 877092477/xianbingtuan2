//
//  FNcardDetailItemPeCell.m
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcardDetailItemPeCell.h"

@implementation FNcardDetailItemPeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.titleLB=[[UILabel alloc]init];
    self.titleLB.font=[UIFont systemFontOfSize:13];
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.titleLB];
    
    self.sumLB=[[UILabel alloc]init];
    self.sumLB.font=[UIFont systemFontOfSize:13];
    self.sumLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.sumLB];
    
    self.dateLB=[[UILabel alloc]init];
    self.dateLB.font=[UIFont systemFontOfSize:12];
    self.dateLB.textColor=RGB(200,200,200);
    [self addSubview:self.dateLB];
    
    self.line=[[UIView alloc]init];
    self.line.backgroundColor=RGB(245,245,245);
    [self addSubview:self.line];
    
    [self incomposition];
}

-(void)incomposition{
    
    CGFloat inter_10=10;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, inter_10).topSpaceToView(self, 10).heightIs(15);
    [self.titleLB setSingleLineAutoResizeWithMaxWidth:150];
    
    self.dateLB.sd_layout
    .leftSpaceToView(self, inter_10).bottomSpaceToView(self, 10).heightIs(15);
    [self.dateLB setSingleLineAutoResizeWithMaxWidth:200];
    
    self.line.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(1);
    
    self.sumLB.sd_layout
    .centerYEqualToView(self).rightSpaceToView(self,10).heightIs(20);
    [self.sumLB setSingleLineAutoResizeWithMaxWidth:150];
    
}

-(void)setModel:(FNDayCardZoModel *)model{
    _model=model;
    if(model){
       self.titleLB.text=model.str;
       self.dateLB.text=model.time;
       self.sumLB.text=model.fp_money;
    }
}
@end
