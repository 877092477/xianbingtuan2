//
//  FNTeamPromoteViewModel.m
//  SuperMode
//
//  Created by jimmy on 2017/10/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNTeamPromoteViewModel.h"

@implementation FNTeamPromoteViewModel
- (void)jm_initialize{
    @weakify(self);
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber, id input) {
        @strongify(self);
        NSString *APIUrl=@"mod=appapi&act=appHhr&ctrl=myteamOrder";
        if ([self.SkipUIIdentifier isEqualToString:@"buy_jingdong"]) {
            APIUrl=@"mod=appapi&act=appJdShareOrder&ctrl=hhrTeamOrder";
        }
        if ([self.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
            APIUrl=@"mod=appapi&act=appPddShareOrder&ctrl=hhrTeamOrder";
        }
        
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"type":@(self.type),@"p":@(self.jm_page),@"show_ysh":@"1"}];
        [FNRequestTool requestWithParams:params api:APIUrl respondType:(ResponseTypeModel) modelType:@"FNPromotePublicModel" success:^(id respondsObject) {
            [SVProgressHUD dismiss];
            //
            self.model = respondsObject;
            self.titles = @[[NSString stringWithFormat:@"全部(%ld)",self.model.all.integerValue],[NSString stringWithFormat:@"已付款(%ld)",self.model.yfk.integerValue],[NSString stringWithFormat:@"已失效(%ld)",self.model.ysx.integerValue],[NSString stringWithFormat:@"已结算(%ld)",self.model.yjs.integerValue],[NSString stringWithFormat:@"已收货(%ld)",self.model.ysh.integerValue]];
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
