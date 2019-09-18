//
//  FNPartnerCenterViewModel.m
//  SuperMode
//
//  Created by jimmy on 2017/10/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerCenterViewModel.h"
#import "FNPartnerCenterViewModel.h"


@implementation FNPartnerCenterViewModel
- (void)jm_initialize{
    @weakify(self);
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber, id input) {
       @strongify(self);
        [FNRequestTool requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}] api:@"mod=appapi&act=appHhr&ctrl=hhrIndex" respondType:(ResponseTypeModel) modelType:@"FNPartnerCenterModel" success:^(id respondsObject) {
            //
            self.model = respondsObject;
            [self getfxicoMethod];
            [subscriber sendCompleted];
        } failure:^(NSString *error) {
            //
            [self.refreshUI sendNext:nil];
            [subscriber sendCompleted];
        } isHideTips:NO];
        return nil;
    };
}

-(void)getfxicoMethod{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  @"time":[NSString GetNowTimes],
                                                                                  @"token":UserAccessToken
                                                                                  }];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:@"mod=appapi&act=dg_fxico&ctrl=hhrzx" successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            [SVProgressHUD dismiss];
            NSMutableArray *IconArr=[[NSMutableArray alloc]init];
            NSArray *arr=[dict objectForKey:XYData];
            for (NSDictionary *dic in arr) {
                DisCenterIconModel *model=[DisCenterIconModel mj_objectWithKeyValues:dic];
                [IconArr addObject:model];
            }
            self.CenterIconModel=IconArr;
            [self.refreshUI sendNext:nil];
        }else{
            //[XYNetworkAPI queryFinishTip:dict];
            //[XYNetworkAPI cancelAllRequest];
            [self getfxicoMethod];
        }
    } failureBlock:^(NSString *error) {
        //[XYNetworkAPI cancelAllRequest];
        //[self.refreshUI sendNext:nil];
        [self getfxicoMethod];
    }];
}

@end
