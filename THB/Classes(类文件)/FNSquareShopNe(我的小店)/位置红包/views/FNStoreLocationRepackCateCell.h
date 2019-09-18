//
//  FNStoreLocationRepackCateCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/23.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreLocationRepackCateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreLocationRepackCateCell : UITableViewCell


- (void)setModel: (FNStoreLocationRepackCateModel*)model;
- (void)setIsSelected: (BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
