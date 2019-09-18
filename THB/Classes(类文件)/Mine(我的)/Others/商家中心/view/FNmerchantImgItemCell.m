//
//  FNmerchantImgItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchantImgItemCell.h"

@implementation FNmerchantImgItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.bgImgView.cornerRadius=5;
    self.bgImgView.clipsToBounds = YES; 
    
}

-(void)setDaModel:(FNMerchantItemMeModel *)daModel{
    _daModel=daModel;
    if(daModel){
        [self.bgImgView setUrlImg:daModel.img];
    }
}
@end
