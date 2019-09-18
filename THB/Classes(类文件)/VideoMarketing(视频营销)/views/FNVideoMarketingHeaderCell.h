//
//  FNVideoMarketingHeaderCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNVideoMarketingHeaderCell;
@protocol FNVideoMarketingHeaderCellDelegate <NSObject>

- (void)headerdidMoreClick: (FNVideoMarketingHeaderCell*)header;

@end

@interface FNVideoMarketingHeaderCell : UICollectionReusableView

@property (nonatomic, weak) id<FNVideoMarketingHeaderCellDelegate> delegate;

- (void)setImage: (nullable NSString*)imgUrl withTitle: (NSString*)title isMoreShow: (BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
