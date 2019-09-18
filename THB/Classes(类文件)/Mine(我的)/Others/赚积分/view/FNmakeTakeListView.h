//
//  FNmakeTakeListView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmakeTakeListItemCell.h"
#import "FNMakeTmodel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmakeTakeListViewDegate <NSObject>
// 点击
- (void)inMakeTakeListAction:(id)model;
// 点击任务详情
- (void)inMakeTakeListDetailsAction:(id)model;
// 点击失败原因
- (void)inMakeTakeSeletedCauseOfFailureAction:(id)model;
@end
@interface FNmakeTakeListView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,FNmakeTakeListItemCellDegate>

@property(nonatomic,strong)UICollectionView* collectionview;

@property(nonatomic,strong)NSArray* dataArr;

@property(nonatomic,strong)NSMutableArray* modelArr;

@property(nonatomic ,weak) id<FNmakeTakeListViewDegate> delegate;

 

@end

NS_ASSUME_NONNULL_END
