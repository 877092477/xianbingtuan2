//
//  FNProfitStatisticsViewModel.m
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNProfitStatisticsViewModel.h"

@implementation FNProfitStatisticsViewModel
- (void)jm_initialize{
    @weakify(self);
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber, id input) {
        @strongify(self);
        [FNRequestTool requestWithParams:[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}] api:@"mod=appapi&act=appHhr&ctrl=dl_list" respondType:(ResponseTypeModel) modelType:@"FNProfitStatisticsModel" success:^(id respondsObject) {
            //
            self.contents  = nil;
            self.model = respondsObject;
            [self.refreshUI sendNext: nil];
            [subscriber sendCompleted];
        } failure:^(NSString *error) {
            //
            [self.refreshUI sendNext: nil];
            [subscriber sendCompleted];
        } isHideTips:NO];
        return nil;
    };
}
- (NSArray *)datas{
    if (_datas == nil) {
        _datas =@[@[@[@"预估收入",@"本月预估",@"上月预估"],@[@"结算收入",@"本月结算",@"上月结算"],@[@"生钱报表",@"可用余额",@"累计收益"],@""],@[@"累计获得自己推广收益",@"累计获得团队推广分成收益"]];
    }
    return _datas;
}
- (NSArray *)contents{
    if (_contents == nil) {
        _contents =@[@[@[@"",@" 0.00",@" 0.00"],@[@"",@" 0.00",@" 0.00"],@[@"",@" 0.00",@" 0.00"]],@[@" 0.00",@" 0.00"]];
        if (self.model) {
            _contents = @[@[@[@"",[NSString stringWithFormat:@" %.2f",[self.model.byyg floatValue]],[NSString stringWithFormat:@" %.2f",[self.model.syyg floatValue]]],@[@"",[NSString stringWithFormat:@" %.2f",[self.model.byjs floatValue]],[NSString stringWithFormat:@" %.2f",[self.model.syjs floatValue]]],@[@"",[NSString stringWithFormat:@" %.2f",[self.model.dlcommission floatValue]],[NSString stringWithFormat:@" %.2f",[self.model.commission_sum floatValue]]]],@[[NSString stringWithFormat:@" %.2f",[self.model.own_sum floatValue]],[NSString stringWithFormat:@" %.2f",[self.model.team_sum floatValue]]]];
        }
    }
    return _contents;
}

- (RACSubject *)withdrawsubject{
    if (_withdrawsubject == nil) {
        _withdrawsubject = [RACSubject subject];
    }
    return _withdrawsubject;
}
@end
