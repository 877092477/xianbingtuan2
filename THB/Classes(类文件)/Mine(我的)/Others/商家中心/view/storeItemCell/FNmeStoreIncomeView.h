//
//  FNmeStoreIncomeView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmeStoreInTextItemCell.h"
#import "FNmerchantIconItemCell.h"
#import "FNMerchantMeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmeStoreIncomeViewDelegate <NSObject>
// 点击
- (void)inMeStoreIncomeAction:(id)model isType:(NSString *)type;

@end
@interface FNmeStoreIncomeView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView* collectionview;

@property(nonatomic,strong)NSArray* dataArr;

@property(nonatomic,strong)NSMutableArray* modelArr;

@property(nonatomic,weak)id<FNmeStoreIncomeViewDelegate> delegate;

@property(nonatomic,strong)FNMerchantMeModel  *model;

@end

NS_ASSUME_NONNULL_END
