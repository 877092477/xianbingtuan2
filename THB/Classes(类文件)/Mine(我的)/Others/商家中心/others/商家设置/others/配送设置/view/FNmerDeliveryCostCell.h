//
//  FNmerDeliveryCostCell.h
//  珍购多
//
//  Created by Jimmy on 2019/6/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FNmerDeliveryCostCellDelegate <NSObject>
// 编辑
- (void)didmerCostEditorAction:(NSIndexPath*)index withContent:(NSString*)content;

@end
@interface FNmerDeliveryCostCell : UICollectionViewCell
@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UITextField  *compileField;
@property (nonatomic, strong)UIView  *lineView;
@property (nonatomic, strong)NSIndexPath  *index;
@property (nonatomic, weak)id<FNmerDeliveryCostCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
