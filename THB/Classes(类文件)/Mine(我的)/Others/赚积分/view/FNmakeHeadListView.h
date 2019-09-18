//
//  FNmakeHeadListView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmakeHeadItemCell.h"
#import "FNMakeTmodel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmakeHeadListView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView* collectionview;

@property(nonatomic,strong)NSArray* dataArr;
@property(nonatomic,strong)NSString* textColor;

 

@end

NS_ASSUME_NONNULL_END
