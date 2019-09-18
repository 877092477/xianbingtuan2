//
//  FNWelfareViewModel.m
//  THB
//
//  Created by Jimmy on 2018/1/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNWelfareViewModel.h"

@implementation FNWelfareViewModel
-(void)jm_initialize{
    @weakify(self);
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber, id input) {
        @strongify(self);
        
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_fls&ctrl=index" respondType:(ResponseTypeArray) modelType:@"MenuModel" success:^(id respondsObject) {
            //
            [SVProgressHUD dismiss];
            [self.list removeAllObjects];
            [self.list addObjectsFromArray:respondsObject];
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
- (NSMutableArray *)list{
    if (_list == nil) {
        _list = [NSMutableArray new];
    }
    return _list;
}
@end
