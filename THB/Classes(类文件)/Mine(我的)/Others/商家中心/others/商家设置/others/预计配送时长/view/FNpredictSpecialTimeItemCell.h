//
//  FNpredictSpecialTimeItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNpredictDeliveryTimeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNpredictSpecialTimeItemCellDelegate <NSObject>
// 编辑时长
- (void)didpredictSpecialTimeAction:(NSIndexPath*)index withContent:(NSString*)content; 
// 选择时间 开始 ~ 结束
- (void)didpredictSpecialTimeSeletedSDateAction:(NSIndexPath*)index;
// 删除
- (void)didpredictSpecialTimeDeleteAction:(NSIndexPath*)index; 
@end
@interface FNpredictSpecialTimeItemCell : UICollectionViewCell<UITextFieldDelegate>
@property (nonatomic, strong)UIButton  *dateBtn;
@property (nonatomic, strong)UIButton  *deleteBtn; 
@property (nonatomic, strong)UILabel   *titleLB; 
@property (nonatomic, strong)UIView  *compileView;
@property (nonatomic, strong)UITextField  *compileField;
@property (nonatomic, strong)UILabel   *hintLB;
@property (nonatomic, strong)FNpredictSpecialTimeModel   *model;
@property (nonatomic, strong)NSIndexPath  *index;
@property (nonatomic, weak)id<FNpredictSpecialTimeItemCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
