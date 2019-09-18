//
//  FNshopTendStoreRowNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/11/22.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXTagsView.h"
#import "FNStoreThendNeModel.h"

@interface FNshopTendStoreRowNeCell : UICollectionViewCell
/** 店铺图片 **/
@property (nonatomic, strong)UIImageView* storeImage;

/** 店铺名字 **/
@property (nonatomic, strong)UILabel* storeName;

/** 店铺距离 **/
@property (nonatomic, strong)UILabel* distanceLB;

/** 店铺位置 **/
@property (nonatomic, strong)UILabel* locationLB;

/** 赏 **/
@property (nonatomic, strong)UILabel* rewardLB;

/** line **/
@property (nonatomic, strong)UILabel* lineLB;

@property (nonatomic, strong)NSDictionary *dicModel;

@property (nonatomic ,strong)LXTagsView *tagsView;

@end


