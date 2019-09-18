//
//  FNStoreGoodsSelectCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/16.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreManagerGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreGoodsSelectCell : UITableViewCell

- (void) setModel: (FNStoreManagerGoodsModel*)model;
- (void) setIsSelected: (BOOL) isSelected ;

@end

NS_ASSUME_NONNULL_END
