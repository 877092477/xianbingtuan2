//
//  FNwrapPayItemAeCell.m
//  THB
//
//  Created by Jimmy on 2019/2/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNwrapPayItemAeCell.h"

@implementation FNwrapPayItemAeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.payImg=[[UIImageView alloc]init];
    [self addSubview:self.payImg]; 
    
    self.nameLB=[[UILabel alloc]init];
    self.nameLB.font=kFONT14;
    self.nameLB.textColor=RGB(173, 173, 173);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.nameLB];
    
    self.remarkLB=[[UILabel alloc]init];
    self.remarkLB.font=kFONT12;
    self.remarkLB.textColor=RGB(173, 173, 173);
    self.remarkLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.remarkLB];
    
    self.stateImg=[[UIImageView alloc]init];
    [self addSubview:self.stateImg];

    [self incomposition];
    
    
}

-(void)incomposition{
    
    CGFloat inter_20=20;
    
    self.payImg.sd_layout
    .leftSpaceToView(self,0).centerYEqualToView(self).heightIs(30).widthIs(30);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.payImg, inter_20).topEqualToView(self.payImg).heightIs(17);
    [self.nameLB setSingleLineAutoResizeWithMaxWidth:150];
    
    self.remarkLB.sd_layout
    .leftSpaceToView(self.payImg, inter_20).topSpaceToView(self.nameLB, 0).heightIs(15);
    [self.remarkLB setSingleLineAutoResizeWithMaxWidth:200];
    
    self.stateImg.sd_layout
    .rightSpaceToView(self, 0).centerYEqualToView(self).widthIs(20).heightIs(20);
    
}
-(void)setModel:(FNpackagePayNaModel *)model{
    _model=model;
    if(model){
       self.nameLB.text=model.title;
       
       self.remarkLB.text=model.sum;
       
//       self.payImg.image=IMAGE(model.img);
        [self.payImg sd_setImageWithURL:URL(model.img)];
       if(model.state==1){
          self.stateImg.image=IMAGE(@"FN_fxzY_img");
       }else{
          self.stateImg.image=IMAGE(@"FN_fxzNo_img");
       }
       
    }
}
@end
