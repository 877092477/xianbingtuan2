//
//  FNIntergralMallDetailRecordCell.h
//  THB
//
//  Created by Weller Zhao on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNIntergralMallDetailRecordCell;
@protocol FNIntergralMallDetailRecordCellDelegate <NSObject>

- (void)didGoodsClick:(FNIntergralMallDetailRecordCell*)cell;

@end

@interface FNIntergralMallDetailRecordCell : UICollectionViewCell

@property (nonatomic, weak) id<FNIntergralMallDetailRecordCellDelegate> delegate;
@property (nonatomic, strong) UIImageView *imgRecord;

- (void)setRecords: (NSArray<NSString*>*)records;

@end

NS_ASSUME_NONNULL_END
