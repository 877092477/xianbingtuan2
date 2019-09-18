//
//  FNmerGradeView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerGradeItemCell.h"
#import "FNmerchentReviewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerGradeView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView* collectionview;

@property(nonatomic,strong)NSArray *imgArr;
@property(nonatomic,assign)NSInteger itemGap;
@property(nonatomic,assign)BOOL isBead;
@property(nonatomic,strong)FNmerchentReviewModel *model;
@end

NS_ASSUME_NONNULL_END
