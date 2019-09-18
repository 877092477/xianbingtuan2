//
//  FNNewConnectionModel.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/6/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewConnectionModel.h"

@implementation FNNewConnectionNavDataModel

@end

@implementation FNNewConnectionNavModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNNewConnectionNavDataModel class]};
}


@end

@implementation FNNewConnectionDataModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNNewConnectionDataFriendModel class]};
}

@end

@implementation FNNewConnectionDataFriendModel


@end

@implementation FNNewConnectionStatisModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNNewConnectionStatisDataModel class]};
}

@end

@implementation FNNewConnectionStatisDataModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"teamcount":[FNNewConnectionStatisDetailModel class],
             @"daycount":[FNNewConnectionStatisDetailModel class]};
}

@end

@implementation FNNewConnectionCate2Model

@end

@implementation FNNewConnectionContaceModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNNewConnectionDataFriendModel class]};
}

@end

@implementation FNNewConnectionStatisDetailModel


@end

@implementation FNNewConnectionCateSortModel


@end

@implementation FNNewConnectionCateListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"sort":[FNNewConnectionCateSortModel class]};
}

@end

@implementation FNNewConnectionCateModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNNewConnectionCateListModel class]};
}

@end

@implementation FNNewConnectionModel


@end
