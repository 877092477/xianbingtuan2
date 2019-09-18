//
//  FNDistrictWorthItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNDistrictWorthItemCell.h"

@implementation FNDistrictWorthItemCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNDistrictWorthItemCellID";
    FNDistrictWorthItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    //100
    
    self.bgImgView=[[UIImageView alloc]init];
    self.bgImgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgImgView];
    
    self.daytitleLB=[[UILabel alloc]init];
    [self addSubview:self.daytitleLB];
    self.dayPriceLB=[[UILabel alloc]init];
    [self addSubview:self.dayPriceLB];
    self.coinTitleLB=[[UILabel alloc]init];
    [self addSubview:self.coinTitleLB];
    self.coinLB=[[UILabel alloc]init];
    [self addSubview:self.coinLB];
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.daytitleLB.font=[UIFont systemFontOfSize:12];
    self.daytitleLB.textColor=RGB(102, 102, 102);
    self.daytitleLB.textAlignment=NSTextAlignmentCenter;
    
    self.dayPriceLB.font=[UIFont systemFontOfSize:18];
    self.dayPriceLB.textColor=RGB(51, 51, 51);
    self.dayPriceLB.textAlignment=NSTextAlignmentCenter;
    
    self.coinTitleLB.font=[UIFont systemFontOfSize:12];
    self.coinTitleLB.textColor=RGB(102, 102, 102);
    self.coinTitleLB.textAlignment=NSTextAlignmentCenter;
    
    self.coinLB.font=[UIFont systemFontOfSize:18];
    self.coinLB.textColor=RGB(51, 51, 51);
    self.coinLB.textAlignment=NSTextAlignmentCenter;
    
    self.hintLB.font=[UIFont systemFontOfSize:12];
    self.hintLB.textColor=RGB(102, 102, 102);
    self.hintLB.textAlignment=NSTextAlignmentCenter;
    
    
    CGFloat lbWith=(FNDeviceWidth-39)/2;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 16).topSpaceToView(self, 0).rightSpaceToView(self, 10).bottomSpaceToView(self, 0);
    
    self.daytitleLB.sd_layout
    .leftSpaceToView(self, 17).topSpaceToView(self, 16).heightIs(16).widthIs(lbWith);
    
    self.dayPriceLB.sd_layout
    .leftSpaceToView(self, 17).topSpaceToView(self.daytitleLB, 4).heightIs(20).widthIs(lbWith);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 17).topSpaceToView(self.dayPriceLB, 8).heightIs(16).widthIs(lbWith);
    
    
    self.coinTitleLB.sd_layout
    .rightSpaceToView(self, 17).topSpaceToView(self, 16).heightIs(16).widthIs(lbWith);
    
    self.coinLB.sd_layout
    .rightSpaceToView(self, 17).topSpaceToView(self.coinTitleLB, 4).heightIs(20).widthIs(lbWith);
    
}
-(void)setModel:(FNDistrictCoinModel *)model{
    _model=model;
    if(model){
        self.daytitleLB.textColor=[UIColor colorWithHexString:model.qkb_sm_color];
        self.hintLB.textColor=[UIColor colorWithHexString:model.qkb_sm_color];
        self.coinTitleLB.textColor=[UIColor colorWithHexString:model.qkb_sm_color];
        self.coinLB.textColor=[UIColor colorWithHexString:model.qkb_sm_color];
        
        
        self.dayPriceLB.textColor=[UIColor colorWithHexString:model.qkb_bz_color];
        self.coinLB.textColor=[UIColor colorWithHexString:model.qkb_bz_color];
        [self.bgImgView setNoPlaceholderUrlImg:model.qkb_my_bg];
        NSArray *qkb_worthArr=model.qkb_worth_info;
        if(qkb_worthArr.count>0){
            FNDistrictCoinWorthItemModel *itemModel=[FNDistrictCoinWorthItemModel mj_objectWithKeyValues:qkb_worthArr[0]];
            self.daytitleLB.text=itemModel.title;
            self.dayPriceLB.text=itemModel.price;
            self.hintLB.text=itemModel.detail;
        }
        if(qkb_worthArr.count>1){
            FNDistrictCoinWorthItemModel *itemModel=[FNDistrictCoinWorthItemModel mj_objectWithKeyValues:qkb_worthArr[1]];
            self.coinTitleLB.text=itemModel.title;
            self.coinLB.text=itemModel.price;
        }
    }
}

@end
