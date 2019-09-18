//
//  FNNewPeopleWelfareDeNewCell.h
//  THBTests
//
//  Created by 吴建良 on 2019/9/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNwelfDeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNNewPeopleWelfareDeNewCellDelegate <NSObject>

// 点击
- (void)inSeletedGoodsItemNewClick:(NSInteger)dicTry setion:(NSIndexPath*)indexPath;

@end
@interface FNNewPeopleWelfareDeNewCell : UICollectionViewCell
/** 商品img **/
@property (nonatomic, strong)UIImageView* goodsImageView;
/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 到手价 **/
@property (nonatomic, strong)UILabel* dsjLB;
/** 价格 **/
@property (nonatomic, strong)UILabel* priceLB;
/** 原价 **/
@property (nonatomic, strong)UILabel* rawLB;
/** 已抢数量 **/
@property (nonatomic, strong)UILabel* amountLB;
/** 马上抢 **/
@property (nonatomic, strong)UIButton* grabBtn;
/** line **/
@property (nonatomic, strong)UIView* line;

@property (nonatomic, strong)NSDictionary *itemDictry;

@property (nonatomic, strong)NSIndexPath* indexPath;
@property(nonatomic,strong)NSArray* dataArr;
@property(nonatomic ,weak) id<FNNewPeopleWelfareDeNewCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
