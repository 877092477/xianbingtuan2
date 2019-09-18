//
//  FNtradeMenusCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMHorizontalMenuView.h"
#import "FNtradeMenusImgsCell.h"
#import "FNtradeHomeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNtradeMenusCellDelegate <NSObject>
// 点击
- (void)inTradeMenusSeletedAction:(NSInteger)index;

@end
@interface FNtradeMenusCell : UICollectionViewCell<FMHorizontalMenuViewDelegate,FMHorizontalMenuViewDataSource>
@property(nonatomic,strong)FMHorizontalMenuView *listView;

@property(nonatomic,weak)id<FNtradeMenusCellDelegate> delegate;

@property(nonatomic,strong)FNtradeHomeModel *model;

@end

NS_ASSUME_NONNULL_END
