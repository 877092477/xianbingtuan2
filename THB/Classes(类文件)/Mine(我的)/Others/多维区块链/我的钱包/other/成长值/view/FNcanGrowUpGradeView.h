//
//  FNcanGrowUpGradeView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNcandiesGradeItemCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcanGrowUpGradeView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView* collectionview;

@property(nonatomic,strong)NSArray* dataArr;
@property(nonatomic,strong)NSString* textColor;

@end

NS_ASSUME_NONNULL_END
