//
//  FNAPIHome.m
//  THB
//
//  Created by jimmy on 2017/5/4.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNAPIHome.h"
#import "MenuModel.h"
#import "MenuModel.h"
#import "XYTitleModel.h"
#import "FNBaseProductModel.h"
#import "HotSearchHeadColumnModel.h"
#import "FNBrandShopModel.h"
#import "JMProductDetailModel.h"

static NSString* const _home_api_productdetailtool = @"mod=mlt&act=xrfl&ctrl=tburl";
//4.6红包提示设置
static NSString* const _home_api_setnotice = @"mod=mlt&act=qhb&ctrl=hbtx";
@implementation FNAPIHome
+ (FNAPIHome *)apiHomeForBannerWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{

    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_home_getSlides];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSArray *data = respondsObject[DataKey];
        NSMutableArray* result = [NSMutableArray new];
        if (data.count > 0) {
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MenuModel* model = [MenuModel mj_objectWithKeyValues:obj];
                [result addObject:model];
            }];
        }
        success(result);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return  tool;

}
+ (FNAPIHome *)apiHomeForQuickEntranceWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_home_getIcon];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSArray *data = respondsObject[DataKey];
        NSMutableArray* result = [NSMutableArray new];
        if (data.count > 0) {
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MenuModel* model = [MenuModel mj_objectWithKeyValues:obj];
                [result addObject:model];
            }];
        }
        success(result);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return  tool;
}
+ (FNAPIHome *)apiHomeForNavCategoriesWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_home_getCates];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSArray *data = respondsObject[DataKey];
        NSMutableArray* result = [NSMutableArray new];
        if (data.count > 0) {
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XYTitleModel* model = [XYTitleModel mj_objectWithKeyValues:obj];
                [result addObject:model];
            }];
        }
        success(result);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return  tool;
}
+ (FNAPIHome *)apiHomeForNewNavCategoriesWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_Newhome_getCates];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSArray *data = respondsObject[DataKey];
        NSMutableArray* result = [NSMutableArray new];
        if (data.count > 0) {
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XYTitleModel* model = [XYTitleModel mj_objectWithKeyValues:obj];
                [result addObject:model];
            }];
        }
        success(result);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return  tool;
}
+ (FNAPIHome *)apiHomeForProductsWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_home_getGoods];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSArray *data = respondsObject[DataKey];
        NSMutableArray* result = [NSMutableArray new];
        if (data.count > 0) {
            [SVProgressHUD dismiss];

            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNBaseProductModel* model = [FNBaseProductModel mj_objectWithKeyValues:obj];
                model.data = obj;
                [result addObject:model];
            }];
        }
        success(result);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
            [SVProgressHUD dismiss];

        }
    } isHideTips:flag];
    return  tool;
}
+ (FNAPIHome *)apiHomeForNewProductsWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_Newhome_getGoods];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSLog(@"商品:%@",respondsObject);
        NSArray *data = respondsObject[DataKey];
        NSMutableArray* result = [NSMutableArray new];
        if (data.count > 0) {
            [SVProgressHUD dismiss];
            
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNBaseProductModel* model = [FNBaseProductModel mj_objectWithKeyValues:obj];
                model.data = obj;
                [result addObject:model];
            }];
        }
        success(result);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
            [SVProgressHUD dismiss];
            
        }
    } isHideTips:flag];
    return  tool;
}
+ (FNAPIHome *)apiHomeForPromotionalProductWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_home_proGoods];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSArray *data = respondsObject[DataKey];
        NSMutableArray* result = [NSMutableArray new];
        if (data.count > 0) {
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNBaseProductModel* model = [FNBaseProductModel mj_objectWithKeyValues:obj];
                [result addObject:model];
            }];
        }
        success(result);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return  tool;
}

+ (FNAPIHome *)apiHomeForSpecialAreaWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_home_gettuwen];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
            NSArray *data = respondsObject[DataKey];
            NSMutableArray* result = [NSMutableArray new];
            if ( data.count > 0) {
                [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MenuModel* model = [MenuModel mj_objectWithKeyValues:obj];
                    [result addObject:model];
                }];
            }
            success(result);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return  tool;
}

+ (FNAPIHome *)apiHomeForPosterWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_home_getpic];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSArray *data = respondsObject[DataKey];
        NSMutableArray* result = [NSMutableArray new];
        if (data.count > 0) {
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MenuModel* model = [MenuModel mj_objectWithKeyValues:obj];
                [result addObject:model];
            }];
        }
        success(result);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return tool;
}

+ (FNAPIHome *)apiHomeForHotSearchHeadColumnWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_home_getType];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSArray *data = respondsObject[DataKey];
        NSMutableArray* result = [NSMutableArray new];
        if (data.count > 0) {
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HotSearchHeadColumnModel* model = [HotSearchHeadColumnModel mj_objectWithKeyValues:obj];
                [result addObject:model];
            }];
        }
        success(result);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return tool;
}

#pragma mark - brand sale
+ (FNAPIHome *)apiBrandForStoreListWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_brand_getDp];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSArray *data = respondsObject[DataKey];
        NSMutableArray* result = [NSMutableArray new];
        if (data.count > 0) {
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNBrandShopModel* model = [FNBrandShopModel mj_objectWithKeyValues:obj];
                [result addObject:model];
            }];
        }
        success(result);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return tool;
}
+ (FNAPIHome *)apiBrandForStoreCategoriesWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_brand_getShopCates];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSArray *data = respondsObject[DataKey];
        NSMutableArray* result = [NSMutableArray new];
        if (data.count > 0) {
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XYTitleModel* model = [XYTitleModel mj_objectWithKeyValues:obj];
                [result addObject:model];
            }];
        }
        success(result);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return tool;
}
#pragma mark - 商城返利
+ (FNAPIHome *)apiHomeRequestRebateBannerWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_home_rebatebanner];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        NSArray *data = respondsObject[DataKey];
        NSMutableArray* result = [NSMutableArray new];
        if (data.count > 0) {
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MenuModel* model = [MenuModel mj_objectWithKeyValues:obj];
                [result addObject:model];
            }];
        }
        success(result);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return tool;
}


+ (FNAPIHome*)apiHomeRequestProductDetailToolWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_api_home_productdetailtool];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        JMProductDetailModel*model = [JMProductDetailModel mj_objectWithKeyValues:respondsObject[DataKey]];
        success(model);
        
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return tool;
}

+ (FNAPIHome*)apiHomeRequestSetNoticeWithParams:(NSMutableDictionary*)params success:(RequestSuccess)success failure:(RequestFailure)failure isHidden:(BOOL)flag{
    FNAPIHome *tool = [FNAPIHome requestWithParams:params andURL:_home_api_setnotice];
    [tool startRequestWithCompletionBlockWithSuccess:^(id respondsObject) {
        success(SuccessValue);
    } failure:^(NSString *error) {
        if (failure) {
            failure(error);
        }
    } isHideTips:flag];
    return tool;
}
@end
