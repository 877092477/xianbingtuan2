//
//  FNGoodsSelectorCell.h
//  THB
//
//  Created by Weller Zhao on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNGoodsSelectorCell : UICollectionViewCell

@property (nonatomic, assign, setter=setIsSelected:) BOOL isSelected;

- (void)setTitle: (NSString*)title;
//- (void)setSelected: (BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
