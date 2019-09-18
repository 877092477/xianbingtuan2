//
//  FNSpquantityNeView.m
//  THB
//
//  Created by Jimmy on 2018/9/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNSpquantityNeView.h"

@implementation FNSpquantityNeView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI
{
    
    self.QuantityTitleLabel = [[UILabel alloc] init];
    self.QuantityTitleLabel.font = kFONT13;
    [self addSubview:self.QuantityTitleLabel];
    
    self.QuantityLabel = [[UILabel alloc] init];
    self.QuantityLabel.textAlignment = NSTextAlignmentCenter;
    self.QuantityLabel.font = kFONT13;
    [self addSubview:self.QuantityLabel];
    
    //加
    self.addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.addBtn setImage:IMAGE(@"btn_details_number_nor1") forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.addBtn];
    
    //减
    self.minusBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.minusBtn setImage:IMAGE(@"btn_details_number_nor") forState:UIControlStateNormal];
    [self.minusBtn addTarget:self action:@selector(minusBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.minusBtn];
    [self setOtherdistribution];
    
}
-(void)setOtherdistribution{
    CGFloat interval_10 = 10;
    
    self.QuantityTitleLabel.sd_layout
    .leftSpaceToView(self, 10).heightIs(20).topSpaceToView(self, interval_10);
    [self.QuantityTitleLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.addBtn.sd_layout
    .rightSpaceToView(self, 10).topSpaceToView(self, interval_10).heightIs(20).widthIs(20);
    
    self.QuantityLabel.sd_layout
    .rightSpaceToView(self.addBtn, 0).heightIs(20).topSpaceToView(self, interval_10).widthIs(60);
    
    self.minusBtn.sd_layout
    .rightSpaceToView(self.QuantityLabel, 0).topSpaceToView(self, interval_10).heightIs(20).widthIs(20);
}
- (void)layoutSubviews
{
    [super layoutSubviews];
   
    
    
}
-(void)setQuantity:(NSInteger)Quantity{
    _Quantity=Quantity;
    if(Quantity){
        self.QuantityTitleLabel.text=@"购买";
        self.QuantityLabel.text=[NSString stringWithFormat:@"%ld",(long)Quantity];
        if(Quantity==1){
            self.minusBtn.userInteractionEnabled = NO;
        }else{
            self.minusBtn.userInteractionEnabled = YES;
        }
    }
    
}
-(void)addBtnClick{
    if ( [self.delegate respondsToSelector:@selector(SpeciAddQuantity:)] ) {
        [self.delegate SpeciAddQuantity:self.indexPath];
    }
}
-(void)minusBtnClick{
    if ( [self.delegate respondsToSelector:@selector(SpeciMinusQuantity:)] ) {
        [self.delegate SpeciMinusQuantity:self.indexPath];
    }
}

@end
