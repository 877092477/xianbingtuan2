//
//  FNclockInPayCell.m
//  THB
//
//  Created by Jimmy on 2019/2/27.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNclockInPayCell.h"

@implementation FNclockInPayCell
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
    
    self.stateImg=[[UIImageView alloc]init];
    self.stateImg.cornerRadius=15/2;
    self.stateImg.borderWidth=1;
    self.stateImg.borderColor = RGB(240, 240, 240);
    
    [self addSubview:self.stateImg];
    
    self.lineView=[[UIView alloc]init];
    self.lineView.backgroundColor=RGB(240, 240, 240);
    [self addSubview:self.lineView];
    
    [self incomposition];
    
}

-(void)incomposition{
    
    self.payImg.sd_layout
    .leftSpaceToView(self,15).centerYEqualToView(self).heightIs(20).widthIs(20);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.payImg, 10).topEqualToView(self.payImg).heightIs(17);
    [self.nameLB setSingleLineAutoResizeWithMaxWidth:150];
    
    self.stateImg.sd_layout
    .rightSpaceToView(self, 15).centerYEqualToView(self).widthIs(15).heightIs(15);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 15).rightSpaceToView(self, 15).bottomSpaceToView(self, 0).heightIs(1);
    
}

-(void)setModel:(FNclockInTypeItemModel *)model{
    _model=model;
    if(model){
        [self.payImg setUrlImg:model.img];
        self.nameLB.text=model.str;
        if(model.state==1){
           self.stateImg.image=IMAGE(@"FN_grerenSEimg");
        }else{
           self.stateImg.image=IMAGE(@"");
        }
        
        
    }
    
}
@end
