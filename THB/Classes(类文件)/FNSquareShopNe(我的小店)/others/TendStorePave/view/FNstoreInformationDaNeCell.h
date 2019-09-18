//
//  FNstoreInformationDaNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/11/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNstoreInformationDaModel.h"
@protocol FNstoreInformationDaNeCellDelegate <NSObject>
// 拨打电话
- (void)ringUpStoreCommodityAction;
@end
@interface FNstoreInformationDaNeCell : UICollectionViewCell

/** 店铺名字 **/
@property (nonatomic, strong)UILabel* storeName;

/** 赏 **/
@property (nonatomic, strong)UILabel* rewardLB;

/** 人均消费 **/
@property (nonatomic, strong)UILabel* consumeLB;

/** 店铺位置图片 **/
@property (nonatomic, strong)UIImageView* locationImage;

/** 店铺位置 **/
@property (nonatomic, strong)UILabel* locationLB;

/** 店铺电话图片 **/
@property (nonatomic, strong)UIImageView* phoneImage;

/** 店铺电话 **/
@property (nonatomic, strong)UILabel* phoneLB;

/** line **/
@property (nonatomic, strong)UILabel* lineLB;

@property (nonatomic, strong)NSDictionary *dicModel;

@property(nonatomic ,weak) id<FNstoreInformationDaNeCellDelegate> delegate;

@end


