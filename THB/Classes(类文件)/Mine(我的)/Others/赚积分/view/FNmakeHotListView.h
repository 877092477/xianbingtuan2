//
//  FNmakeHotListView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmakeHotItemCell.h"
#import "FNMakeTmodel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmakeHotListViewDegate <NSObject>
// 点击
- (void)inMakeHotListViewAction:(id)model;

@end
@interface FNmakeHotListView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,FNmakeHotItemCellDegate>

@property(nonatomic,strong)UICollectionView* collectionview;

@property(nonatomic,strong)NSArray* dataArr;

@property(nonatomic,strong)NSMutableArray* modelArr;

@property(nonatomic ,weak) id<FNmakeHotListViewDegate> delegate;

 

@end

NS_ASSUME_NONNULL_END
