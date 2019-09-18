//
//  FNConnectionsHomeModel.m
//  THB
//
//  Created by Weller Zhao on 2019/1/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsHomeModel.h"

@implementation FNConnectionsHomeTopIconModel
@end

@implementation FNConnectionsHomeTopModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNConnectionsHomeTopIconModel class]};
}

@end

@implementation FNConnectionsHomeServiceItemModel

@end

@implementation FNConnectionsHomeGroupModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNConnectionsGroupModel class]};
}

@end

@implementation FNConnectionsHomeContactModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNConnectionsHomeServiceItemModel class]};
}

@end


@implementation FNConnectionsHomeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"ABC":[NSString class]};
}

@end
