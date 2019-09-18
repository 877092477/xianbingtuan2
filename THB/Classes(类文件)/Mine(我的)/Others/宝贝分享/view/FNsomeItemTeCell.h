//
//  FNsomeItemTeCell.h
//  THB
//
//  Created by 李显 on 2019/1/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNSomeTeItemModel.h"
#import "FNBaseProductModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNsomeItemTeCellDelegate <NSObject>
// 选择
- (void)inchoiceSomeItemAction:(NSIndexPath*)index withState:(NSInteger)state;

@end
@interface FNsomeItemTeCell : UICollectionViewCell

/** bgView **/
@property (nonatomic, strong)UIView* bgView;
/** 选择按钮 **/
@property (nonatomic, strong)UIButton* choiceBtn;
/** 商品图片 **/
@property (nonatomic, strong)UIImageView* goodsImg;
/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 价格 **/
@property (nonatomic, strong)UILabel* sumLB;
/** 已售 **/
@property (nonatomic, strong)UILabel* soldLB;
/** 预估收益 **/
@property (nonatomic, strong)UILabel* estimateLB;
/** 券图片 **/
@property (nonatomic, strong)UIImageView* ticketImg;
/** 券金额 **/
@property (nonatomic, strong)UILabel* ticketLB; 
/** line **/
@property (nonatomic, strong)UIView* line;
/** model **/
@property (nonatomic, strong)FNBaseProductModel* model;
/** indexPath **/
@property (nonatomic, strong)NSIndexPath* indexPath;
/** delegate **/
@property(nonatomic ,weak) id<FNsomeItemTeCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
