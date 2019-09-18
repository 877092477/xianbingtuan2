//
//  FNPromotionalListViewModel.m
//  THB
//
//  Created by Jimmy on 2017/12/22.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPromotionalListViewModel.h"

@implementation FNPromotionalListViewModel
- (void)jm_initialize{
    @weakify(self);
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber, id input) {
        @strongify(self);
        NSInteger pagesize = 6;
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{PageNumber:@(self.jm_page),TokenKey:UserAccessToken,PageSize:@(pagesize)}];
        if (self.time) {
            params[@"time_"] = self.time;
        }
        if (self.identifier) {
            params[@"type"] = self.identifier;
        }
        if (self.sort) {
            params[@"sort"] = self.sort;
        }
        if (self.cid) {
            params[@"cid"] = self.cid;
        }
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=getgoods&ctrl=getgoods" respondType:(ResponseTypeArray) modelType:@"FNBaseProductModel" success:^(NSArray* respondsObject) { 
            //
            [SVProgressHUD dismiss];
            if (self.jm_page == 1) {
                [self.products removeAllObjects];
                [self.products addObjectsFromArray:respondsObject];
                if (respondsObject.count >= pagesize-1) {
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
            [self jm_initialize];
            [self.refreshUI sendNext:nil];
            [subscriber sendCompleted];
            [self.refreshEndSubject sendNext:@(JMRefreshError)];
        } isHideTips:NO];
        return nil;
    };
}

- (NSMutableArray *)products{
    if (_products == nil) {
        _products = [NSMutableArray new];
    }
    return _products;
}
@end
