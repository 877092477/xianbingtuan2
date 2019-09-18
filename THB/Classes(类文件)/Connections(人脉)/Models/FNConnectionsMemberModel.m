//
//  FNConnectionsMemberModel.m
//  THB
//
//  Created by Weller Zhao on 2019/1/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsMemberModel.h"

@implementation FNConnectionsMemberModel

@end

@implementation FNConnectionsMemberGroupModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNConnectionsMemberModel class]};
}
@end
