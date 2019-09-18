//
//  FNWithdrawViewModel.m
//  SuperMode
//
//  Created by jimmy on 2017/6/15.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNWithdrawViewModel.h"

@implementation FNWithdrawViewModel
- (void)jm_initialize{
    @weakify(self);
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber,id input) {
        @strongify(self);
        //get balance
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
        if (self.type) {
            params[@"type"] = self.type;
        }
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_new_tx&ctrl=index" respondType:(ResponseTypeModel) modelType:@"FNWithdrawMOdel" success:^(FNWithdrawMOdel* respondsObject) {
            [SVProgressHUD dismiss];
            //
            self.model = respondsObject;
            self.balance = self.model.money;
            self.tips =[NSString stringWithFormat:@"%@%@", self.model.wxStr,self.model.txStr];
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            [SVProgressHUD dismiss];
        } failure:^(NSString *error) {
            //
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
        } isHideTips:NO];
        return nil;
    };
    
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        [self.refreshUI sendNext:nil];
    }];
    
}
- (RACSubject *)successSubject{
    if (_successSubject == nil) {
        _successSubject = [RACSubject subject];
    }
    return _successSubject;
}
- (RACCommand *)confirmCommand{
    if (_confirmCommand == nil) {
        _confirmCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                [SVProgressHUD show];
                NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:input];
                params[TokenKey] = UserAccessToken;
                if (self.type) {
                    params[@"type"] = self.type;
                }
                [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_new_tx&ctrl=txDoing" respondType:(ResponseTypeNone) modelType:nil success:^(id respondsObject) {
                    //
                    [SVProgressHUD dismiss];
                    [self.successSubject sendNext:nil];
                    [subscriber sendCompleted];
                    [self.refreshDataCommand execute:nil];
                } failure:^(NSString *error) {
                          [subscriber sendCompleted];
                } isHideTips:NO];
                return nil;
            }];
        }];
    }
    return _confirmCommand;
}
@end
