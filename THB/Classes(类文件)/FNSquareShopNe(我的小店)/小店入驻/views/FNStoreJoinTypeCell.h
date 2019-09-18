//
//  FNStoreJoinTypeCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreJoinTypeCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *lblTag;
- (void)setSelected: (BOOL)isSelected;
@end

NS_ASSUME_NONNULL_END
