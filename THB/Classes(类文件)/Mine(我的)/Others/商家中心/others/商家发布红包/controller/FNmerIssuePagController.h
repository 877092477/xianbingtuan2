//
//  FNmerIssuePagController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNmerIssuePagController : SuperViewController
@property (nonatomic, strong)NSString *typeStyle;

@property (nonatomic, strong)NSString* idAlter;
@property (nonatomic, copy)void (^inMerIssuePagData)(void);
@end

NS_ASSUME_NONNULL_END
