//
//  FNmerMoneyOffController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNmerMoneyOffController : SuperViewController
@property (nonatomic, strong)NSString *typeStyle;
@property (nonatomic, strong)NSString *activityID;
@property (nonatomic, copy)void (^inMerMoneyOffData)(void);
@end

NS_ASSUME_NONNULL_END
