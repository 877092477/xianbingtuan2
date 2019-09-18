//
//  FNConnectionsNoticeController.h
//  THB
//
//  Created by Weller Zhao on 2019/3/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNConnectionsNoticeController : SuperViewController

@property (nonatomic, copy) NSString* uid;

@property (nonatomic, copy) NSString* room;

@property (nonatomic, copy) NSString* target;

@property (nonatomic, copy) NSString* nickname;
@property (nonatomic, copy) NSString* notice;


@end

NS_ASSUME_NONNULL_END
