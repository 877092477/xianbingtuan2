//
//  FNPartnerGoodsViewModel.m
//  SuperMode
//
//  Created by jimmy on 2017/10/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerGoodsViewModel.h"

@implementation FNPartnerGoodsViewModel
- (void)jm_initialize{
    @weakify(self);
    
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber, id input) {
        @strongify(self);
        NSInteger pagesize = 5;
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"p":@(self.jm_page),TokenKey:UserAccessToken,@"num":@(pagesize)}];
        if (self.cid) {
            params[@"cid"] = self.cid;
        }
        if (self.keyword) {
            params[@"keyword"] = self.keyword;
        }
        if (self.sort) {
            params[@"sort"] = self.sort;
        }
        if (self.start_price) {
            params[@"start_price"] = self.start_price;
        }
        if (self.end_price) {
            params[@"end_price"] = self.end_price;
        }
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHhrGoods&ctrl=getGoods" respondType:(ResponseTypeArray) modelType:@"FNPartnerGoodsModel" success:^(NSArray* respondsObject) {
            //
            [SVProgressHUD dismiss];
            if (self.jm_page == 1) {
                [self.products removeAllObjects];
                [self.products addObjectsFromArray:respondsObject];
                if (respondsObject.count>= pagesize) {
                    [self.refreshEndSubject sendNext:@(JMRefreshHeader_HasMoreData)];
                }else{
                    [self.refreshEndSubject sendNext:@(JMRefreshHeader_HasNoMoreData)];
                }
            }else{
                [self.products addObjectsFromArray:respondsObject];
                if (respondsObject.count>= pagesize) {
                    [self.refreshEndSubject sendNext:@(JMRefreshFooter_HasMoreData)];
                }else{
                    [self.refreshEndSubject sendNext:@(JMRefreshFooter_HasNoMoreData)];
                }
            }
            [self.refreshUI sendNext:nil];
            [subscriber sendCompleted];
        } failure:^(NSString *error) {
            //
        } isHideTips:YES];
        return nil;
    };
}
- (RACCommand *)categorycommand{
    if (_categorycommand == nil) {
        _categorycommand  = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [FNRequestTool requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{}] api:@"mod=appapi&act=appHhr&ctrl=getCate" respondType:(ResponseTypeArray) modelType:@"FNCategoryModel" success:^(id respondsObject) {
                    //
                    [SVProgressHUD dismiss];
                    self.categories  =respondsObject;
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                } failure:^(NSString *error) {
                    //
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                } isHideTips:NO];
                return nil;
            }];
        }];
    }
    return _categorycommand;
}


- (NSMutableArray<FNPartnerGoodsModel *> *)products
{
    if (_products == nil) {
        _products = [NSMutableArray new];
    }
    return _products;
}
- (NSMutableArray *)cateNames{
    if (_cateNames ==nil) {
        _cateNames = [NSMutableArray new];
    }
    return _cateNames;
}
- (void)setCategories:(NSArray<FNCategoryModel *> *)categories{
    _categories = categories;
    if (_categories.count >=1) {
        [self.cateNames removeAllObjects];
        [_categories enumerateObjectsUsingBlock:^(FNCategoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.cateNames addObject:obj.catename];
        }];
    }
}
@end
