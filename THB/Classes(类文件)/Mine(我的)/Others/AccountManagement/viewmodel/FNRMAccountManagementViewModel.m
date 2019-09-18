//
//  FNRMAccountManagementViewModel.m
//  THB
//
//  Created by Jimmy on 2018/1/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNRMAccountManagementViewModel.h"

@implementation FNRMAccountManagementViewModel
- (void)jm_initialize{
    @weakify(self);
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber, id input) {
        @strongify(self);
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_fls&ctrl=skzh" respondType:(ResponseTypeArray) modelType:@"FNRMAccountManagementModel" success:^(id respondsObject) {
            //
            [SVProgressHUD dismiss]; 
            self.list = respondsObject;
            [self.refreshUI sendNext:nil];
            [subscriber sendCompleted];
        } failure:^(NSString *error) {
            //
        } isHideTips:NO isCache:NO];
        return nil;
    };
}
@end
