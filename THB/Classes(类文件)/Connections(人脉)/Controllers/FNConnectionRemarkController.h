//
//  FNConnectionRemarkController.h
//  THB
//
//  Created by Weller Zhao on 2019/3/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FNConnectionRemarkControllerDelegate <NSObject>

- (void)didNameChange: (NSString*)name;

@end

@interface FNConnectionRemarkController : SuperViewController

@property (nonatomic, copy) NSString* uid;

@property (nonatomic, copy) NSString* room;

@property (nonatomic, copy) NSString* target;

@property (nonatomic, copy) NSString* nickname;

@property (nonatomic, weak) id<FNConnectionRemarkControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
