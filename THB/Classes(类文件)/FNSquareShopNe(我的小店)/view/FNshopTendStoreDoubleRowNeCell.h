//
//  FNshopTendStoreDoubleRowNeCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXTagsView.h"
#import "FNStoreThendNeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNshopTendStoreDoubleRowNeCell : UICollectionViewCell
///** 店铺图片 **/
//@property (nonatomic, strong)UIImageView* storeImage;
//
///** 店铺名字 **/
//@property (nonatomic, strong)UILabel* storeName;

///** 店铺距离 **/
//@property (nonatomic, strong)UILabel* distanceLB;
//
///** 店铺位置 **/
//@property (nonatomic, strong)UILabel* locationLB;
//
///** 赏 **/
//@property (nonatomic, strong)UILabel* rewardLB;
//
///** line **/
//@property (nonatomic, strong)UILabel* lineLB;
//
@property (nonatomic, strong)NSDictionary *dicModel;
//
//@property (nonatomic ,strong)LXTagsView *tagsView;

- (void)setIsLeft: (BOOL) isLeft;

@end

NS_ASSUME_NONNULL_END
