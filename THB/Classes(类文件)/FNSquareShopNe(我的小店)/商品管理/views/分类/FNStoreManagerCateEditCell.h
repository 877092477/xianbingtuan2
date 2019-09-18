//
//  FNStoreManagerCateEditCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/10.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNStoreManagerCateEditCell;
@protocol FNStoreManagerCateEditCellDelegate <NSObject>

- (void) cellDidDeleteClick: (FNStoreManagerCateEditCell*)cell;
- (void) cellDidEditClick: (FNStoreManagerCateEditCell*)cell;
- (void) cellDidUpClick: (FNStoreManagerCateEditCell*)cell;
- (void) cellDidDownClick: (FNStoreManagerCateEditCell*)cell;

@end

@interface FNStoreManagerCateEditCell : UITableViewCell

@property (nonatomic, weak) id<FNStoreManagerCateEditCellDelegate> delegate;
@property (nonatomic, strong) UILabel *lblTitle;

- (void) setEditable: (BOOL)editable upable: (BOOL)upable downable: (BOOL)downable;

@end

NS_ASSUME_NONNULL_END
