//
//  FNMineImageCell.h
//  THB
//
//  Created by Weller Zhao on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FNMineImageCell;
@protocol FNMineImageCellDelegate <NSObject>

- (void) imageCell: (FNMineImageCell*)cell didClickAt: (NSInteger)index;

@end

@interface FNMineImageCell : UITableViewCell

@property (nonatomic, weak) id<FNMineImageCellDelegate> delegate;

- (void)setImages: (NSArray<UIImage*> *)images column: (int)column ;
- (void) setPadding: (CGFloat)padding ;

@end

NS_ASSUME_NONNULL_END
