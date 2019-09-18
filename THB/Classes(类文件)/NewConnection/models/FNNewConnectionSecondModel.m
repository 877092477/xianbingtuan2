//
//  FNNewConnectionSecondModel.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/14.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewConnectionSecondModel.h"


@implementation FNNewConnectionSecondModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"search_data":[FNNewConnectionCateListModel class],
             @"list": [FNNewConnectionMemModel class]
             };
}

@end
