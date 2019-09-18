//
//  FNMeStoreIncomeCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMeStoreIncomeCell.h"

@implementation FNMeStoreIncomeCell
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
    
    self.listView=[[FNmeStoreIncomeView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth-20, 10)];
    [self addSubview:self.listView];
}

-(void)setModel:(FNMerchantMeModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setUrlImg:model.img];
        if([model.type isEqualToString:@"store_income"]){
           self.listView.frame=CGRectMake(0, 0, FNDeviceWidth-20, 40);
        }
        //else if([model.type isEqualToString:@"member_mem_ico"]){
        //   self.listView.frame=CGRectMake(0, 0, FNDeviceWidth-20, 89);
        //}
        self.listView.model=model;
    }
}
@end
