//
//  FNGoodsSelectorCountCell.h
//  THB
//
//  Created by Weller Zhao on 2019/1/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNGoodsSelectorCountCell;
@protocol FNGoodsSelectorCountCellDelegate <NSObject>

- (void) goodSelector: (FNGoodsSelectorCountCell*)cell didCountChange: (int)count;

@end

@interface FNGoodsSelectorCountCell : UICollectionViewCell

//先设置最大值
@property (nonatomic, assign, setter=setMaxCount:) int maxCount;
@property (nonatomic, assign, setter=setCount:) int count;

@property (nonatomic, weak) id<FNGoodsSelectorCountCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
