//
//  FNCollectionViewCellIdentifier.m
//  THB
//
//  Created by zhongxueyu on 2018/8/21.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNCollectionViewCellIdentifier.h"

@implementation FNCollectionViewCellIdentifier
- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier data:(id)data rowHeight:(float)rowHeight {
    if (self = [super init]) {
        self.cellIdentifier = cellIdentifier;
        self.data = data;
        self.rowHeight = rowHeight;
    }
    return self;
}
@end
