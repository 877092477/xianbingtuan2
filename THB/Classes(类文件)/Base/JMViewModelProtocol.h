//
//  JMViewModelProtocol.h
//  SuperMode
//
//  Created by jimmy on 2017/6/8.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    JMRefreshHeader_HasMoreData = 0,
    JMRefreshHeader_HasNoMoreData,
    JMRefreshFooter_HasMoreData,
    JMRefreshFooter_HasNoMoreData,
    JMRefreshError,
    JMRefreshUI,
} JMRefreshDataStatus;
@protocol JMViewModelProtocol <NSObject>
@optional

- (instancetype)initWithModel:(id)model;

/**
 *  初始化
 */
- (void)jm_initialize;

@end
