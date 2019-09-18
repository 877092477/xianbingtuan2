//
//  FNVideoModel.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoModel.h"

@implementation FNVideoLineModel
@end

@implementation FNVideoModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNVideoLineModel class]};
}

@end
