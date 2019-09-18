//
//  FNBrandShopModel.m
//  THB
//
//  Created by jimmy on 2017/5/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNBrandShopModel.h"

@implementation FNBrandShopModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"shop_goods":[FNBaseProductModel class],@"shop_yhq":[JMShop_yhq class]};
}
- (CGFloat)goodsH{
    if (_shop_goods.count > 0) {
        _goodsH = floor(FNDeviceWidth/3.0) + 15*2 +10*2;
    }
    return  _goodsH;
}
@end
@implementation JMShop_yhq



@end
