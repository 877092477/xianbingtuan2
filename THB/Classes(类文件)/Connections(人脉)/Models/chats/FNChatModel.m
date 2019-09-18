//
//  FNChatModel.m
//  THB
//
//  Created by Weller Zhao on 2019/2/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNChatModel.h"
#import "FNChatManager.h"

@implementation FNChatModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

+(NSString *)getTableName
{
    return [NSString stringWithFormat:@"FNChatModel_uid%@", FNChatManager.shareInstance.user.id];
}

@end


@implementation FNChatGoodsModel

@end

@implementation FNChatSettingModel



@end
