//
//  FNmerchantIconItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchantIconItemCell.h"

@implementation FNmerchantIconItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.nameLB.font=[UIFont systemFontOfSize:12];
    self.nameLB.textColor=RGB(255, 50, 63);
    self.nameLB.textAlignment=NSTextAlignmentCenter;
    
    self.imgView.sd_layout
    .topSpaceToView(self, 22).centerXEqualToView(self).widthIs(25).heightIs(25);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 5).topSpaceToView(self.imgView, 8).rightSpaceToView(self, 5).heightIs(17);
    
    self.imgView.contentMode=UIViewContentModeScaleAspectFit;
    self.imgView.clipsToBounds = YES;
   
}
-(void)setDaModel:(FNMerchantItemMeModel *)daModel{
    _daModel=daModel;
    if(daModel){
        [self.imgView setUrlImg:daModel.img];
        self.nameLB.text=daModel.title;
        self.nameLB.textColor=[UIColor colorWithHexString:daModel.font_color];
    }
}
@end
