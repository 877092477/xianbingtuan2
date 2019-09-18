//
//  FNlibScreenItemUeCell.h
//  THB
//
//  Created by 李显 on 2019/1/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNSomeTeItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNlibScreenItemUeCell : UICollectionViewCell
/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;

/** 排序图片 **/
@property (nonatomic, strong)UIImageView *sortImageView;

/** 名字 **/
@property (nonatomic, strong)FNSomeGoodsCateModel *model;

@end

NS_ASSUME_NONNULL_END
