//
//  FNCommSortHFView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYCyclePagerView.h"
#import "FNCommSortHFitemCell.h"
#import "FNCommodityFieldModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNCommSortHFViewDelegate <NSObject>
// 点击分类
- (void)didCommSortHFViewDelegateItemAction:(NSInteger)index;

@end
@interface FNCommSortHFView : UIView<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>
 
@property (nonatomic, strong)TYCyclePagerView* pagerView;
@property(nonatomic,strong)NSMutableArray* dataArr;
@property (nonatomic ,weak) id<FNCommSortHFViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
