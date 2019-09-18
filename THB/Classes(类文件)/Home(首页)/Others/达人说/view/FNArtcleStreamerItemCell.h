//
//  FNArtcleStreamerItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "FNExpertSortNaNodel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNArtcleStreamerItemCellDelegate <NSObject>
// 点击头像或者名字
- (void)didArtcleStreamerItemAction:(NSIndexPath*)indexS;
- (void)didArtcleStreamerSeletedHeadItemAction:(id)indexS;
@end
@interface FNArtcleStreamerItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIImageView   *showImg;
@property (nonatomic, strong)UIImageView   *headImg;
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *nameLB;
@property (nonatomic, strong)UIButton  *checkBtn;
@property (nonatomic, strong)FNEssayItemDModel *model;

@property (nonatomic ,weak) id<FNArtcleStreamerItemCellDelegate> delegate;
@property (nonatomic, strong)NSIndexPath  *indexS;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
