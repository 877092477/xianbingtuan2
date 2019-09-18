//
//  FNCollectionViewCellIdentifier.h
//  THB
//
//  Created by zhongxueyu on 2018/8/21.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNCollectionViewCellIdentifier : NSObject
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, strong) id data;
@property (nonatomic, assign) float rowHeight;
@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, assign) NSTimeInterval banner_speed;

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier
                                  data:(id)data
                             rowHeight:(float)rowHeight;
@end
