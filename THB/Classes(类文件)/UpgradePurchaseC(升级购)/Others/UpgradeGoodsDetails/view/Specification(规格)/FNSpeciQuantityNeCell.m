//
//  FNSpeciQuantityNeCell.m
//  THB
//
//  Created by Jimmy on 2018/9/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNSpeciQuantityNeCell.h"

@implementation FNSpeciQuantityNeCell
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
    [self.contentView addSubview:self.QuantityTitleLabel];
    
    self.QuantityLabel = [[UILabel alloc] init];
    self.QuantityLabel.textAlignment = NSTextAlignmentCenter;
    self.QuantityLabel.font = kFONT13;
    [self.contentView addSubview:self.QuantityLabel];
    
    //加
    self.addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.addBtn setImage:IMAGE(@"btn_details_number_nor1") forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.addBtn];
    
    //减
    self.minusBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.minusBtn setImage:IMAGE(@"btn_details_number_nor") forState:UIControlStateNormal];
    [self.minusBtn addTarget:self action:@selector(minusBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.minusBtn];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat interval_10 = 10;
    
    self.QuantityTitleLabel.sd_layout
    .leftSpaceToView(self.contentView, 10).heightIs(20).topSpaceToView(self.contentView, interval_10);
    [self.QuantityTitleLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.addBtn.sd_layout
    .rightSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, interval_10).heightIs(20).widthIs(20);
    
    self.QuantityLabel.sd_layout
    .rightSpaceToView(self.addBtn, 0).heightIs(20).centerYEqualToView(self.addBtn).widthIs(60);
    
    self.minusBtn.sd_layout
    .rightSpaceToView(self.QuantityLabel, 0).topSpaceToView(self.contentView, interval_10).heightIs(20).widthIs(20);
    
    
}
-(void)setQuantity:(NSInteger)Quantity{
    _Quantity=Quantity;
    if(Quantity){
        self.QuantityLabel.text=[NSString stringWithFormat:@"%ld",(long)Quantity];
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
