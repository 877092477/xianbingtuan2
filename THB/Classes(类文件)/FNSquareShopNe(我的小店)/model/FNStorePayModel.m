//
//  FNStorePayModel.m
//  THBTests
//
//  Created by Weller on 2019/7/29.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStorePayModel.h"

@implementation FNStorePayModel

@end

@implementation FNStorePayConfirmModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"red_packet_list":[FNStoreMyCouponeModel class],
             @"yhq_list":[FNStoreMyCouponeModel class]
             };
}
@end
