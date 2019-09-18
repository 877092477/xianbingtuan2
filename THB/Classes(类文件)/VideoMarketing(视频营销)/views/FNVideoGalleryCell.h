//
//  FNVideoGalleryCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNVideoGalleryCell;
@protocol FNVideoGalleryCellDelegate <NSObject>

- (void)cell: (FNVideoGalleryCell*)cell didItemClickAt: (NSInteger) index;

@end

@interface FNVideoGalleryCell : UICollectionViewCell

@property (nonatomic, weak) id<FNVideoGalleryCellDelegate> delegate;

- (void)setImageUrls: (NSArray<NSString*>*)urls;

@end

NS_ASSUME_NONNULL_END
