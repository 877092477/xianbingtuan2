//
//  FNImageTextCollectionViewCell.h
//  THB
//
//  Created by Weller Zhao on 2019/1/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNImageTextCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imgHeader;

- (void)setText: (NSString*)text;

- (CGFloat) getWidth;
@end

NS_ASSUME_NONNULL_END
