//
//  FNcardheDayTeView.h
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNcardDayItemTeCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcardheDayTeView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *dayCollectionview;
@property (nonatomic, strong)NSArray *dataArr;
@end

NS_ASSUME_NONNULL_END
