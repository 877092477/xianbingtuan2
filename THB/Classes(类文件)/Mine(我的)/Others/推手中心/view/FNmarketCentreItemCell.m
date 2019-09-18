//
//  FNmarketCentreItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmarketCentreItemCell.h"

@implementation FNmarketCentreItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.recommendLB=[[UILabel alloc]init];
    [self addSubview:self.recommendLB];
    
    self.sumHintLB=[[UILabel alloc]init];
    [self addSubview:self.sumHintLB];
    
    self.sumLB=[[UILabel alloc]init];
    [self addSubview:self.sumLB];
    
    self.stateLB=[[UILabel alloc]init];
    [self addSubview:self.stateLB];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.titleLB.font=[UIFont systemFontOfSize:16];
    self.titleLB.textColor=RGB(24, 24, 24);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.recommendLB.font=[UIFont systemFontOfSize:12];
    self.recommendLB.textColor=RGB(255, 108, 0);
    self.recommendLB.textAlignment=NSTextAlignmentLeft;
    
    self.sumLB.font=[UIFont systemFontOfSize:16];
    self.sumLB.textColor=RGB(255, 40, 40);
    self.sumLB.textAlignment=NSTextAlignmentRight;
    
    self.sumHintLB.font=[UIFont systemFontOfSize:11];
    self.sumHintLB.textColor=RGB(140, 140, 140);
    self.sumHintLB.textAlignment=NSTextAlignmentRight;
    
    self.stateLB.font=[UIFont systemFontOfSize:10];
    self.stateLB.textColor=RGB(255, 40, 40);
    self.stateLB.textAlignment=NSTextAlignmentCenter;
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 10).centerYEqualToView(self).widthIs(40).heightIs(40);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.imgView, 10).rightSpaceToView(self, 110).topSpaceToView(self, 15).heightIs(20);
    
    self.recommendLB.sd_layout
    .leftSpaceToView(self.imgView, 10).rightSpaceToView(self, 115).topSpaceToView(self, 42).heightIs(17);
    
    self.sumLB.sd_layout
    .rightSpaceToView(self, 10).topSpaceToView(self, 15).heightIs(20).widthIs(95);
    
    self.stateLB.sd_layout
    .rightSpaceToView(self, 10).topSpaceToView(self.sumLB, 6).heightIs(15).widthIs(40);
    
    self.sumHintLB.sd_layout
    .rightSpaceToView(self.stateLB, 10).topSpaceToView(self.sumLB, 6).heightIs(17).widthIs(60);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(1); 
    
    self.imgView.clipsToBounds = YES;
    self.imgView.cornerRadius=20;
    self.lineView.backgroundColor=RGB(232, 232, 232);
    
}
-(void)setModel:(FNMarketCentreStoreItemModel *)model{
    _model=model;
    if(model){
        [self.imgView setUrlImg:model.img];
        self.titleLB.text=model.name;
        self.recommendLB.text=model.time;
        self.sumLB.text=model.commission_str;
        self.sumHintLB.text=model.str;
        self.sumLB.textColor=[UIColor colorWithHexString:model.commission_color];
        self.recommendLB.textColor=[UIColor colorWithHexString:model.time_color];
        self.sumHintLB.textColor=[UIColor colorWithHexString:model.str_color];
        self.stateLB.text=model.status;
        self.stateLB.textColor = [UIColor colorWithHexString:model.status_color];
        CGFloat sumLBW=[self.sumLB.text kr_getWidthWithTextHeight:20 font:16];
        if(sumLBW>150){
           sumLBW=150;
        }
        self.sumLB.sd_resetLayout
        .rightSpaceToView(self, 10).topSpaceToView(self, 15).heightIs(20).widthIs(sumLBW);
        
        self.titleLB.sd_resetLayout
        .leftSpaceToView(self.imgView, 10).rightSpaceToView(self, sumLBW+15).topSpaceToView(self, 15).heightIs(20);
        
        self.stateLB.sd_resetLayout
        .rightSpaceToView(self, 10).topSpaceToView(self.sumLB, 6).heightIs(17).widthIs(40);
        
        self.sumHintLB.sd_resetLayout
        .rightSpaceToView(self.stateLB, 5).topSpaceToView(self.sumLB, 6).heightIs(17).widthIs(60);
        
        self.stateLB.borderWidth=1;
        self.stateLB.borderColor = [UIColor colorWithHexString:model.status_color];
        self.stateLB.cornerRadius=15/2;
        self.stateLB.clipsToBounds = YES;
//        if([model.order_str kr_isNotEmpty]){
//           [self.titleLB fn_changeColorWithTextColor:RGB(140, 140, 140) changeText:model.order_str];
//           [self.titleLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:11] changeText:model.order_str];
//        }
    }
}
@end
