//
//  FNImageSelectCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/4.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNImageSelectCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

- (void)setCheck: (BOOL)check;

@end

NS_ASSUME_NONNULL_END
