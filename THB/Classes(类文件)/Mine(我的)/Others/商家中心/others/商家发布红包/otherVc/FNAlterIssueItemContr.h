//
//  FNAlterIssueItemContr.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FNAlterIssueItemContrDelegate <NSObject>
// 修改成功
- (void)didMerAlterIssueRevampMsg;

@end
@interface FNAlterIssueItemContr : SuperViewController
@property (nonatomic, strong)NSString *typeStyle;
@property (nonatomic, strong)NSString *pagId;
@property (nonatomic, weak)id<FNAlterIssueItemContrDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
