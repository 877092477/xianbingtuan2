//
//  FNNewStoreGoodsCateCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNNewStoreGoodsCateCell;
@protocol FNNewStoreGoodsCateCellDelegate <NSObject>

- (void)cateCell: (FNNewStoreGoodsCateCell*)cell didCateClickAt: (NSInteger) index;

@end

@interface FNNewStoreGoodsCateCell : UICollectionViewCell

@property (nonatomic, weak) id<FNNewStoreGoodsCateCellDelegate> delegate;

- (void)setTitles: (NSArray<NSString*>*)cates selected: (NSInteger)index;

@end

NS_ASSUME_NONNULL_END
