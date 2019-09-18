//
//  FNPartnerApplyViewModel.m
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerApplyViewModel.h"

@implementation FNPartnerApplyViewModel
- (void)jm_initialize{
    @weakify(self);
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber, id input) {
        @strongify(self);
        [FNRequestTool requestWithParams:nil api:@"mod=appapi&act=appHhr&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNPartnerApplyModel" success:^(id respondsObject) {
            //
            [SVProgressHUD dismiss];
            self.model = respondsObject;
            [self.refreshUI sendNext:nil];
            [subscriber sendCompleted];
        } failure:^(NSString *error) {
            //
            [self.refreshUI sendNext:nil];
            [subscriber sendCompleted];
        } isHideTips:NO];
        return nil;
    };
}
- (RACCommand *)confirmCommand{
    if (_confirmCommand == nil) {
        _confirmCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:input];
                params[TokenKey] = UserAccessToken;
                [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHhr&ctrl=sqhhr" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
                    //
                    
                    [FNTipsView showTips:@"申请成功"];
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                } failure:^(NSString *error) {
                    //
                    [subscriber sendNext:@(NO)];
                    [subscriber sendCompleted];
                } isHideTips:NO];
                return nil;
            }];
        }];
    }
    return _confirmCommand;
}
@end
