//
//  FNmeStoreInTextItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeStoreInTextItemCell.h"

@implementation FNmeStoreInTextItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews{
    self.titleLB=[[UILabel alloc]init];
    self.numberLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    [self addSubview:self.numberLB];
    self.titleLB.font=kFONT12;
    self.titleLB.textColor=RGB(60, 60, 60);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    self.numberLB.textColor=RGB(140, 140, 140);
    self.numberLB.textAlignment=NSTextAlignmentCenter;
    self.numberLB.font=kFONT16;
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.lineView.backgroundColor=RGB(232, 232, 232);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 5).rightSpaceToView(self, 5).bottomSpaceToView(self, 0).heightIs(20);
    
    self.numberLB.sd_layout
    .leftSpaceToView(self, 5).rightSpaceToView(self, 5).topSpaceToView(self, 0).heightIs(20);
    
    self.lineView.sd_layout
    .topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(1);
    
}

-(void)setDaModel:(FNMerchantItemMeModel *)daModel{
    _daModel=daModel;
    if(daModel){
        self.titleLB.text=daModel.tips;
        self.numberLB.text=daModel.number; 
        self.titleLB.textColor=[UIColor colorWithHexString:daModel.tips_color];
        self.numberLB.textColor=[UIColor colorWithHexString:daModel.number_color];
        self.lineView.hidden=daModel.lineState;
    }
}
@end
