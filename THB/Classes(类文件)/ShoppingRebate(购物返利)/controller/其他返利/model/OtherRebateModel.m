//
//  OtherRebateModel.m
//  THB
//
//  Created by Fnuo-iOS on 2018/5/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "OtherRebateModel.h"

@implementation OtherRebateModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"topList":[OtherRebatetopListModel class],@"keyword":[FNTBRebateHotModel class],@"cate":[XYTitleModel class]};
}

@end
