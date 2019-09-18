//
//  FNLiveBroadcastModel.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveBroadcastModel.h"

@implementation FNLiveBroadcastButtonModel

@end

@implementation FNLiveBroadcastNoticeModel

@end

@implementation FNLiveBroadcastModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"ico_list":[FNLiveBroadcastButtonModel class],
             @"img_list":[NSString class]
             };
}
@end
