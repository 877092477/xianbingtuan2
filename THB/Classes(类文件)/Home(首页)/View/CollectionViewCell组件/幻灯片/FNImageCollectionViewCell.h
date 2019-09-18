//
//  FNImageCollectionViewCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
- (void) setPadding: (CGFloat)padding jiange: (CGFloat)jiange;
@end

NS_ASSUME_NONNULL_END
