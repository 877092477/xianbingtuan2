//
//  FNhandConditionsView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNhandConditionItemCell.h"
#import "FNHandSlapdModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNhandConditionsView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView* collectionview;

@property(nonatomic,strong)NSArray* dataArr;
@end

NS_ASSUME_NONNULL_END
