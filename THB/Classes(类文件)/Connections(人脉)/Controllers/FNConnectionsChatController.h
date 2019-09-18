//
//  FNConnectionsChatController.h
//  THB
//
//  Created by Weller Zhao on 2019/1/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FNConnectionsChatControllerDelegate <NSObject>

- (void)didChatUpdate;

@end

@interface FNConnectionsChatController : SuperViewController

@property (nonatomic, copy) NSString* uid;

@property (nonatomic, copy) NSString* room;

@property (nonatomic, copy) NSString* target;

@property (nonatomic, copy) NSString* nickname;

@property (nonatomic, weak) id<FNConnectionsChatControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
