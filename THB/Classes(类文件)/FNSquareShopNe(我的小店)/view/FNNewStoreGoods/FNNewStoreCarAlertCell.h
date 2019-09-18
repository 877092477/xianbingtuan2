//
//  FNNewStoreCarAlertCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/27.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreCarModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNNewStoreCarAlertCell;
@protocol FNNewStoreCarAlertCellDelegate <NSObject>

- (void)didSubClick: (FNNewStoreCarAlertCell*)cell;
- (void)didAddClick: (FNNewStoreCarAlertCell*)cell;

@end

@interface FNNewStoreCarAlertCell : UITableViewCell

@property (nonatomic, strong) id<FNNewStoreCarAlertCellDelegate> delegate;

- (void)setModel: (FNStoreCarModel*)model;

@end

NS_ASSUME_NONNULL_END
