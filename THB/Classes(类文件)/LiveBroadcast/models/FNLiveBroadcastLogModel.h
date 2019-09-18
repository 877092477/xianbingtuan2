//
//  FNLiveBroadcastLogModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNLiveBroadcastLogModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *img;

@end

NS_ASSUME_NONNULL_END
