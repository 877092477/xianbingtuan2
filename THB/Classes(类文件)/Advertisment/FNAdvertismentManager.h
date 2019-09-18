//
//  FNAdvertismentManager.h
//  SuperMode
//
//  Created by Jimmy Ng on 2017/11/29.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNAdvertismentManager : NSObject
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) void (^imgClicked)(UIWindow *window);
@property (nonatomic, copy) void (^finishedWindow)(void);
+ (instancetype)shareManager;
+ (void)hideWithOptions:(UIViewAnimationOptions)options;

@end
