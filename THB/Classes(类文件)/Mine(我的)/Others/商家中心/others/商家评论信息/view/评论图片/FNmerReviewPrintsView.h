//
//  FNmerReviewPrintsView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/10.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerReviewImgCell.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmerReviewPrintsViewDelegate <NSObject>
// 点击评论图片
- (void)inmerReviewPrintsAction:(NSArray*)imgArr isIndex:(NSInteger)index;

@end
@interface FNmerReviewPrintsView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView* collectionview;

@property(nonatomic,strong)NSArray* dataArr;

@property(nonatomic,weak)id<FNmerReviewPrintsViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
