//
//  FNUpgradeGoodsCollectionViewCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/18.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNUpgradeGoodsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UIImageView *imgTag;
@property (nonatomic, strong) UIImageView *imgButton;
@property (nonatomic, strong) UILabel *lblButton;

- (void) setButton: (NSString*)imageUrl ;
- (void) setTag: (NSString*)imageUrl ;
- (void) setIsLeft: (BOOL)isLeft ;

@end

NS_ASSUME_NONNULL_END
