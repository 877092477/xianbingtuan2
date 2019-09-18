//
//  FNStoreLocationRedpackReceiveDetailModel.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/28.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationRedpackReceiveDetailModel.h"

@implementation FNStoreLocationRedpackDetailLabelModel

@end

@implementation FNStoreLocationRedpackDetailRedpackModel

@end

@implementation FNStoreLocationRedpackDetailStoreModel

@end

@implementation FNStoreLocationRedpackDetailRedpackTotalModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"user_list":[NSString class]};
}

@end

@implementation FNStoreLocationRedpackDetailAvdModel

@end


@implementation FNStoreLocationRedpackReceiveDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"label":[FNStoreLocationRedpackDetailLabelModel class]};
}

@end
