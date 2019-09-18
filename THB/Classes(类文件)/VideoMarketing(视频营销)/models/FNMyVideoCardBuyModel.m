//
//  FNMyVideoCardBuyModel.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMyVideoCardBuyModel.h"

@implementation FNMyVideoCardBuyTypeModel

    
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
    
    
@end

@implementation FNMyVideoCardBuyModel
  
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"card_type":[FNMyVideoCardBuyTypeModel class]};
}
    
@end
