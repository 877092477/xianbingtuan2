//
//  FNAfficheDeCell.h
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNDefiniteStoreNeModel.h"
#import "SDCycleScrollView.h"
#import "FNScrollmonkeyView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNAfficheDeCell : UICollectionViewCell
/** 积分公告img **/
@property (nonatomic, strong)UIImageView* definImage;
/** 公告 **/
@property (nonatomic, strong)UILabel* leftLB;
/** model **/
@property (nonatomic, strong)FNDefiniteStoreNeModel* model;
/** 文字跑马灯 **/
//@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;
/** 跑马灯视图 **/
@property (nonatomic, strong)FNScrollmonkeyView* FNMarqueeView;
@property (nonatomic, strong)NSMutableArray* marqueeArray;
@end

NS_ASSUME_NONNULL_END
