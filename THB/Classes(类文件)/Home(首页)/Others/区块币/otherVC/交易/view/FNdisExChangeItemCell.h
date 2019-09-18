//
//  FNdisExChangeItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNdisExchangeAcrossView.h"
#import "FNdistrictExchangeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNdisExChangeItemCellDelegate <NSObject>
// 取消
- (void)didExChangeItemCancelAction:(NSIndexPath*)index;
//点击
- (void)didExChangeItemAcrossAction:(NSIndexPath*)index;

@end
@interface FNdisExChangeItemCell : UICollectionViewCell<FNdisExchangeAcrossViewDelegate>
@property(nonatomic,strong)UILabel *nameLB;
@property(nonatomic,strong)UILabel *countLB;
@property(nonatomic,strong)UILabel *dateLB;
@property(nonatomic,strong)UILabel *stateLine;
@property(nonatomic,strong)UIImageView *stateImg;
@property(nonatomic,strong)UIButton  *rightBtn;
@property(nonatomic,strong)FNdisExchangeAcrossView *acrossview;
@property(nonatomic,strong)NSIndexPath *index;
@property(nonatomic,weak) id<FNdisExChangeItemCellDelegate> delegate;

@property(nonatomic,strong)FNdisExchangeOddItemModel *model;
@property (nonatomic,strong)NSString *type;

@end

NS_ASSUME_NONNULL_END
