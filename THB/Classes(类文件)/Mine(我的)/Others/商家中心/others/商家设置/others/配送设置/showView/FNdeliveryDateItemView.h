//
//  FNdeliveryDateItemView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNdeliverySetsModel.h"
#import "DSHPopupContainer.h"
#import "FNdeliveryDayItemCell.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNdeliveryDateItemViewDelegate <NSObject>
// 选择的时间天
- (void)inDeliveryDateItemWithDate:(NSString*)date withJoint:(NSString*)content;

@end
@interface FNdeliveryDateItemView : UIView<DSHCustomPopupView,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UIButton  *leftBtn;
@property (nonatomic, strong)UIButton  *rightBtn;
@property (nonatomic, strong)UICollectionView* collectionview;
@property (nonatomic, strong)NSMutableArray  *dataArr;
@property (nonatomic, weak)id<FNdeliveryDateItemViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

