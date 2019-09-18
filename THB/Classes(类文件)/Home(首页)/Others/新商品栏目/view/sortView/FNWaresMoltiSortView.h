//
//  FNWaresMoltiSortView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNWaresSortItemACell.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNWaresMoltiSortViewDelegate <NSObject>
// 点击 筛选
- (void)diWaresMoltiSortViewAction:(NSInteger)index;
@end
@interface FNWaresMoltiSortView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView* collectionview;
@property(nonatomic,strong)NSMutableArray* dataArr;
@property (nonatomic ,weak) id<FNWaresMoltiSortViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
