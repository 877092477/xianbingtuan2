//
//  FNDistrictCoinHeadCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNDistrictCoinHeadCell.h"

@implementation FNDistrictCoinHeadCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNDistrictCoinHeadCellID";
    FNDistrictCoinHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
    
    //165 
    
    self.titleLB=[[UILabel alloc]init];
    self.hintLB=[[UILabel alloc]init];
    self.priceLB=[[UILabel alloc]init]; 
    
    [self addSubview:self.titleLB];
    [self addSubview:self.hintLB];
    [self addSubview:self.priceLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=RGB(102, 102, 102);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    
    self.hintLB.font=[UIFont systemFontOfSize:12];
    self.hintLB.textColor=RGB(153, 153, 153);
    self.hintLB.textAlignment=NSTextAlignmentCenter;
    
    self.priceLB.font=[UIFont systemFontOfSize:30];
    self.priceLB.textColor=RGB(51, 51, 51);
    self.priceLB.textAlignment=NSTextAlignmentCenter;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).heightIs(16).rightSpaceToView(self, 15).topSpaceToView(self, 30);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 15).heightIs(16).rightSpaceToView(self, 15).bottomSpaceToView(self, 6);
    
    self.priceLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self.titleLB, 8).heightIs(35).rightSpaceToView(self, 15);
    
    self.typeView=[[FNDistrictCrosswiseView alloc]init];
    [self addSubview:self.typeView];
    self.typeView.frame=CGRectMake(0, 80, FNDeviceWidth, 52);
    
    self.typeView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self.priceLB, 3).heightIs(52).rightSpaceToView(self, 0);
}

-(void)setModel:(FNDistrictCoinModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.qkb_worth;
        self.priceLB.text=model.qkb_my_jiazhi;
        self.hintLB.text=model.qkb_worth_detail;
        self.typeView.dataArr=model.btn_list;
        
        self.titleLB.textColor=[UIColor colorWithHexString:model.qkb_bt_color];
        
        self.hintLB.textColor=[UIColor colorWithHexString:model.qkb_bt_color];
        
        self.priceLB.textColor=[UIColor colorWithHexString:model.qkb_bz_color];
    }
}
@end
