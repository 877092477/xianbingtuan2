//
//  FNHeroRankViewModel.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNHeroRankViewModel.h"

@implementation FNHeroRankViewModel
- (void)jm_initialize{
    @weakify(self);
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber, id input) {
        @strongify(self);
        [FNRequestTool requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{@"p":@(self.jm_page),TokenKey:UserAccessToken}] api:self.index == 0 ?@"mod=appapi&act=appFamily&ctrl=teamUserCount":@"mod=appapi&act=appFamily&ctrl=teamUser" respondType:(ResponseTypeArray) modelType:@"FNHeroRankModel" success:^(NSArray* respondsObject) {
            //
            
            [SVProgressHUD dismiss];
            if (self.jm_page == 1) {
                [self.ranks removeAllObjects];
                [self.ranks addObjectsFromArray:respondsObject];
                if (respondsObject.count>= _jm_pageszie) {
                    [self.refreshEndSubject sendNext:@(JMRefreshHeader_HasMoreData)];
                }else{
                    [self.refreshEndSubject sendNext:@(JMRefreshHeader_HasNoMoreData)];
                }
            }else{
                [self.ranks addObjectsFromArray:respondsObject];
                if (respondsObject.count>= _jm_pageszie) {
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
            [subscriber sendCompleted];
            [self.refreshEndSubject sendNext:@(JMRefreshError)];
        } isHideTips:NO];
        return nil;
    };
}
- (NSMutableArray<FNHeroRankModel *> *)ranks
{
    if (_ranks == nil) {
        _ranks = [NSMutableArray new];
    }
    return _ranks;
}
@end
