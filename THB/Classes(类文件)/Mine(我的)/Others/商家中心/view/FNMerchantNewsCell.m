//
//  FNMerchantNewsCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMerchantNewsCell.h"

@implementation FNMerchantNewsCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.headImgView=[[UIImageView alloc]init];
    [self addSubview:self.headImgView]; 
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    
    self.nameLB.font=[UIFont systemFontOfSize:16];
    self.nameLB.textColor=RGB(255, 50, 63);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.rightBtn.titleLabel.font=kFONT12;
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.headImgView.sd_layout
    .leftSpaceToView(self, 20).bottomSpaceToView(self, 16).widthIs(39).heightIs(39);
    
    self.headImgView.cornerRadius=39/2;
    self.headImgView.clipsToBounds = YES;
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImgView, 15).centerYEqualToView(self.headImgView).widthIs(150).heightIs(20);  
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 0).centerYEqualToView(self.headImgView).heightIs(20).widthIs(75);
    
//    self.rightBtn.imageView.sd_layout
//    .rightSpaceToView(self.rightBtn, 15).widthIs(5).heightIs(9).centerYEqualToView(self.rightBtn);
    
//    self.rightBtn.titleLabel.sd_layout
//    .leftSpaceToView(self.rightBtn, 5).rightSpaceToView(self.rightBtn.imageView, 9).heightIs(15).centerYEqualToView(self.rightBtn);
    
}

-(void)setModel:(FNMerchantHeadMeModel *)model{
    _model=model;
    if(model){
        [self.headImgView setUrlImg:model.img];
        self.nameLB.text=model.name; 
        [self.rightBtn setTitle:model.set_btn forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor colorWithHexString:model.color] forState:UIControlStateNormal];
        self.nameLB.textColor=[UIColor colorWithHexString:model.color];
        
        self.headImgView.borderWidth=1;
        self.headImgView.borderColor = [UIColor whiteColor];
        
    }
}
@end
