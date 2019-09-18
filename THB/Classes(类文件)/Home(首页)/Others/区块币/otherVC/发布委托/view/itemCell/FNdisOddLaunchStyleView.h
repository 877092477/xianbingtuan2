//
//  FNdisOddLaunchStyleView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNOddStyleLItemCell.h"
#import "FNdisOddLaunchModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNdisOddLaunchStyleViewDelegate <NSObject>

- (void)didLaunchStyleAction:(NSIndexPath*)index;

@end

@interface FNdisOddLaunchStyleView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView* collectionview;

@property(nonatomic,strong)NSArray* dataArr;

@property(nonatomic,weak) id<FNdisOddLaunchStyleViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
