//
//  FNFansViewModel.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNFansViewModel.h"

@implementation FNFansViewModel
-(void)jm_initialize{
    @weakify(self);
    
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber, id input) {
        @strongify(self);
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"p":@(self.jm_page)}];
        if (self.sort) {
            params[@"sort"] = self.sort;
        }
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appHhr&ctrl=myFan" respondType:(ResponseTypeModel) modelType:@"FNPromotionalTeamModel" success:^(id respondsObject) {
            [SVProgressHUD dismiss];
            self.model = respondsObject;
            //
            if (self.jm_page == 1) {
                [self.persons removeAllObjects];
                [self.persons addObjectsFromArray:self.model.fan];
                if (self.model.fan.count>= 10) {
                    [self.refreshEndSubject sendNext:@(JMRefreshHeader_HasMoreData)];
                }else{
                    [self.refreshEndSubject sendNext:@(JMRefreshHeader_HasNoMoreData)];
                }
            }else{
                [self.persons addObjectsFromArray:self.model.fan];
                if (self.model.fan.count>= 10) {
                    [self.refreshEndSubject sendNext:@(JMRefreshFooter_HasMoreData)];
                }else{
                    [self.refreshEndSubject sendNext:@(JMRefreshFooter_HasNoMoreData)];
                }
            }
            [self.refreshUI sendNext:nil];
            [subscriber sendCompleted];
        } failure:^(NSString *error) {
            //
        } isHideTips:NO];
        return nil;
    };
}
- (NSMutableArray *)persons
{
    if (_persons == nil) {
        _persons = [NSMutableArray new];
    }
    return _persons;
}
@end
