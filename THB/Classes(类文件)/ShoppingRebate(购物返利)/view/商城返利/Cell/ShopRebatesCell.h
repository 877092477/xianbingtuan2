//
//  ShopRebatesCell.h
//  THB
//
//  Created by Weller Zhao on 2018/12/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopRebatesCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, assign) BOOL isCircle;
@end

NS_ASSUME_NONNULL_END
