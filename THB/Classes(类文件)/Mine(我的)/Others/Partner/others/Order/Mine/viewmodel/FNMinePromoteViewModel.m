//
//  FNMinePromoteViewModel.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMinePromoteViewModel.h"

@implementation FNMinePromoteViewModel
- (void)jm_initialize{
    @weakify(self);
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber, id input) {
        @strongify(self);
        NSString *APIUrl=@"mod=appapi&act=appHhr&ctrl=myOrder";
        if ([self.SkipUIIdentifier isEqualToString:@"buy_jingdong"]) {
            APIUrl=@"mod=appapi&act=appJdShareOrder&ctrl=hhrMyOrder";
        }
        if ([self.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
            APIUrl=@"mod=appapi&act=appPddShareOrder&ctrl=hhrMyOrder";
        }
        
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@(self.index),@"p":@(self.jm_page),TokenKey:UserAccessToken}];
        
        [FNRequestTool requestWithParams:params api:APIUrl respondType:(ResponseTypeModel) modelType:@"FNPromotePublicModel" success:^(id respondsObject) {
            //
            [SVProgressHUD dismiss];
            self.model =respondsObject;
            self.titles = @[[NSString stringWithFormat:@"%ld",self.model.fsxl.integerValue],[NSString stringWithFormat:@"%ld",self.model.jjdz.integerValue],[NSString stringWithFormat:@"%ld",self.model.ljjl.integerValue]];
            //
            if (self.jm_page == 1) {
                [self.list removeAllObjects];
                [self.list addObjectsFromArray:self.model.order];
                if (self.model.order.count>= _jm_pageszie) {
                    [self.refreshEndSubject sendNext:@(JMRefreshHeader_HasMoreData)];
                }else{
                    [self.refreshEndSubject sendNext:@(JMRefreshHeader_HasNoMoreData)];
                }
            }else{
                [self.list addObjectsFromArray:self.model.order];
                if (self.model.order.count>= _jm_pageszie) {
                    [self.refreshEndSubject sendNext:@(JMRefreshFooter_HasMoreData)];
                }else{
                    [self.refreshEndSubject sendNext:@(JMRefreshFooter_HasNoMoreData)];
                }
            }
            [self.refreshUI sendNext:nil];
            [subscriber sendCompleted];
        } failure:^(NSString *error) {
            //
            [self.refreshUI sendNext:nil];
            [self.refreshEndSubject sendNext:@(JMRefreshError)];
            [subscriber sendCompleted];
        } isHideTips:NO];
        return nil;
    };
}
- (NSMutableArray *)list
{
    if (_list == nil) {
        _list = [NSMutableArray new];
    }
    return _list;
}
@end
