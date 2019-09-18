//
//  FNmarScreensfView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmarketScreenItemCell.h"
#import "FNMarketCentreModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmarScreensfViewDelegate <NSObject>
// 点击  状态
-(void)inMarketScreensfSeletedType:(NSString *)type;

@end
@interface FNmarScreensfView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView* collectionview;

@property(nonatomic,strong)NSMutableArray* dataArr;
@property(nonatomic,weak)id<FNmarScreensfViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
