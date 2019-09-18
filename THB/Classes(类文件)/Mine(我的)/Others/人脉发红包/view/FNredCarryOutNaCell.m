//
//  FNredCarryOutNaCell.m
//  THB
//
//  Created by Jimmy on 2019/2/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNredCarryOutNaCell.h"

@implementation FNredCarryOutNaCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.backgroundColor=RGB(243, 243, 243);
    
    self.sumLB=[[UILabel alloc]init];
    self.sumLB.font=[UIFont systemFontOfSize:35];
    self.sumLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.sumLB];
    
    self.remarkLB=[[UILabel alloc]init];
    self.remarkLB.font=kFONT14;
    self.remarkLB.textColor=RGB(204, 204, 204);
    self.remarkLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.remarkLB]; 
    
    self.carryOutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.carryOutBtn.titleLabel.font=kFONT17;
    [self.carryOutBtn setBackgroundImage:IMAGE(@"FN_fhBopaque_img") forState:UIControlStateNormal];
    [self.carryOutBtn setBackgroundImage:IMAGE(@"FN_fhBtn_img") forState:UIControlStateSelected];
    //[self.carryOutBtn addTarget:self action:@selector(choiceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.carryOutBtn];
    
    [self incomposition];
    
}

-(void)incomposition{
    
    CGFloat inter_10=10;
    CGFloat inter_20=20;
    
    self.carryOutBtn.sd_layout
    .leftSpaceToView(self,inter_20).rightSpaceToView(self, inter_20).centerYEqualToView(self).heightIs(40);
    
    self.sumLB.sd_layout
    .leftSpaceToView(self,inter_20).rightSpaceToView(self,inter_20).bottomSpaceToView(self.carryOutBtn, 45).heightIs(40);
    
    self.remarkLB.sd_layout
    .leftSpaceToView(self,inter_10).rightSpaceToView(self,inter_10).topSpaceToView(self.carryOutBtn, 90).heightIs(20);

}

-(void)setModel:(FNRedPackageNaModel *)model{
    _model=model;
    if(model){
        
        self.remarkLB.text=model.alert;
        [self.carryOutBtn setTitle:model.carry forState:UIControlStateNormal];
        CGFloat sumFloat=[model.sum floatValue];
        CGFloat numInt=[model.num integerValue];
        NSInteger statePacket=[model.statePacket integerValue];
        self.sumLB.text=[NSString stringWithFormat:@"¥%.2f",sumFloat];
        if(statePacket==1){
            if(sumFloat>0){
                self.carryOutBtn.selected=YES;
            }else{
                self.carryOutBtn.selected=NO;
            }
        }
        if(statePacket==2){
            if(sumFloat>0&&numInt>0){
                self.carryOutBtn.selected=YES;
            }else{
                self.carryOutBtn.selected=NO;
            }
        }
        
    }
}
@end
