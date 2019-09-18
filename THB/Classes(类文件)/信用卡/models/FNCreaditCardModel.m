//
//  FNCreaditCardModel.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardModel.h"

@implementation FNCreaditCardModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rights":[NSString class]};
}
@end

@implementation FNCreaditCardDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[super mj_objectClassInArray]];
    
    dict[@"rule"] = [NSString class];
    
    return dict;
}

@end

@implementation FNCreaditCardShareIconModel


@end

@implementation FNCreaditCardShareModel

+ (NSDictionary *)mj_objectClassInArray{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[super mj_objectClassInArray]];
    
    dict[@"shar_btn"] = [FNCreaditCardShareIconModel class];
    
    return dict;
}

@end
