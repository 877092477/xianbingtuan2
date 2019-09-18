//
//  FNFamilyViewModel.m
//  SuperMode
//
//  Created by jimmy on 2017/11/4.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNFamilyViewModel.h"

@implementation FNFamilyViewModel
-(void)jm_initialize{
    @weakify(self);
    [FNRequestTool startWithRequests:@[[self requestHeader]] withFinishedBlock:^(NSArray *erros) {
        @strongify(self);
        [self requestTwoHeader];
        //[self requestList];
    }];
    
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber, id input) {
        @strongify(self);
        if(self.seletedState==1){
            [self requestTwoHeader];
        }
        else if(self.seletedState==2){
            [self requestList];
        } 
        [subscriber sendCompleted];
        return nil;
    };
}

- (FNRequestTool *)requestHeader{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appFamily&ctrl=lv_list" respondType:(ResponseTypeArray) modelType:@"FNFamilyHeaderModel" success:^(NSArray* respondsObject) {
        //
        self.Header=respondsObject;
        self.index=self.Header[0].lv;
        //[self.refreshHeader sendNext:nil];
    } failure:^(NSString *error) {
        //
        
    } isHideTips:NO];
}
- (FNRequestTool *)requestTwoHeader{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    if([self.index kr_isNotEmpty]){
        params[@"is_hhr"]=self.index;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appFamily&ctrl=user_lv" respondType:(ResponseTypeArray) modelType:@"FNFamilyHeaderModel" success:^(NSArray* respondsObject) {
        //
        self.twoHeader=respondsObject;
        self.twoIndex=self.twoHeader[0].lv;
        [self.refreshHeader sendNext:nil];
        [self requestList];
    } failure:^(NSString *error) {
        //
        
    } isHideTips:NO];
}

- (FNRequestTool *)requestList{
    //@"is_hhr":self.index,
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"p":@(self.jm_page),TokenKey:UserAccessToken}];
    if([self.twoIndex kr_isNotEmpty]){
        params[@"is_hhr"]=self.twoIndex;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appFamily&ctrl=myHhr" respondType:(ResponseTypeModel) modelType:@"FNPromotionalTeamModel" success:^(FNPromotionalTeamModel* respondsObject) {
        [SVProgressHUD dismiss];
        //
        self.model = respondsObject;
        if (self.jm_page == 1) {
            [self.members removeAllObjects];
            [self.members addObjectsFromArray:respondsObject.fan];
            if (respondsObject.fan.count >= _jm_pageszie) {
                [self.refreshEndSubject sendNext:@(JMRefreshHeader_HasMoreData)];
            }else{
                [self.refreshEndSubject sendNext:@(JMRefreshHeader_HasNoMoreData)];
            }
        }else{
            [self.members addObjectsFromArray:respondsObject.fan];
            if (respondsObject.fan.count >= _jm_pageszie) {
                [self.refreshEndSubject sendNext:@(JMRefreshFooter_HasMoreData)];
            }else{
                [self.refreshEndSubject sendNext:@(JMRefreshFooter_HasNoMoreData)];
            }
        }
        [self.refreshUI sendNext:nil];
    } failure:^(NSString *error) {
        //
        [self.refreshUI sendNext:nil];
        [self.refreshEndSubject sendNext:@(JMRefreshError)];
    } isHideTips:NO];
}

- (NSMutableArray<PTMfan *> *)members{
    if (_members == nil) {
        _members = [NSMutableArray new];
    }
    return _members;
}

- (RACSubject *)refreshHeader{
    if (_refreshHeader == nil) {
        _refreshHeader = [RACSubject subject];
    }
    return _refreshHeader;
}

@end
