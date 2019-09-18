//
//  FNStoreJoinCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreJoinModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreJoinCell : UITableViewCell

- (void)setModel: (FNStoreJoinItemModel*) model withIndex: (NSString*)index;

@end

NS_ASSUME_NONNULL_END
