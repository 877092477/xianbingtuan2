//
//  FNrushPurchaseNeModel.m
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNrushPurchaseNeModel.h"
@implementation FNrushPurchaseNeRedpackModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[FNStoreMyCouponeModel class]};
}
@end

@implementation FNrushPurchaseNeModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"red_packets":[FNrushPurchaseNeRedpackModel class]};
}
@end


@implementation FNrushBuyTypeNeModel

@end


@implementation FNrushPurchCartNeModel

@end

@implementation FNrushBuyMsgModel

@end
