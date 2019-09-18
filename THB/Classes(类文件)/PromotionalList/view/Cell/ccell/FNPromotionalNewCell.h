//
//  FNPromotionalNewCell.h
//  THB
//
//  Created by Weller Zhao on 2019/1/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNHomeProductCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNPromotionalNewCell : FNHomeProductCell

@property (nonatomic, copy, setter=setViewType:) NSString *view_type;

@end

NS_ASSUME_NONNULL_END
