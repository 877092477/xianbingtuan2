//
//  FNMineIconsCell.h
//  THB
//
//  Created by Weller Zhao on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNMineIconsCell : UITableViewCell

typedef void(^MineIconsBlock)(NSInteger index);

- (void)showWithImages: (NSArray*)imgUrls andTitles: (NSArray*)titles clickBlock: (MineIconsBlock) onClick;
- (void)showWithImages: (NSArray*)imgUrls andTitles: (NSArray*)titles andColors: (NSArray*)colors clickBlock: (MineIconsBlock) onClick;
- (void)showTitle: (NSString*)title isShow: (BOOL)isShow;

- (void) setPadding: (CGFloat)padding;
- (void) setBackgroundImage: (NSString*) imageUrl;
@end

NS_ASSUME_NONNULL_END
