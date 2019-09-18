//
//  FNDistrictDealitemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNDistrictDealitemCell.h"

@implementation FNDistrictDealitemCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNDistrictDealitemCellID";
    FNDistrictDealitemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    self.bgImgView=[[UIImageView alloc]init];
    //self.bgImgView.backgroundColor = [UIColor whiteColor];
    self.bgImgView.contentMode=UIViewContentModeScaleAspectFit;//UIViewContentModeCenter;
    self.bgImgView.clipsToBounds=YES;
    [self addSubview:self.bgImgView];
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 10).bottomSpaceToView(self, 0);
}

-(void)setModel:(FNDistrictCoinBtnItemModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setNoPlaceholderUrlImg:model.img];
    }
}
@end
