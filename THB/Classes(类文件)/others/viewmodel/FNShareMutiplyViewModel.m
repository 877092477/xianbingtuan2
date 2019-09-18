//
//  FNShareMutiplyViewModel.m
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNShareMutiplyViewModel.h"

@implementation FNShareMutiplyViewModel
- (void)jm_initialize{
    @weakify(self);
    self.observingRefreshDataCommand = ^RACDisposable *(id<RACSubscriber> subscriber, id input) {
        @strongify(self);
        NSString *APIUrl=@"mod=appapi&act=goods_fenxiang";
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"fnuo_id":self.fnuo_id,TokenKey:UserAccessToken}];
        if([self.getGoodsType kr_isNotEmpty]){
            params[@"getGoodsType"]=self.getGoodsType;
        }
        if ([self.SkipUIIdentifier isEqualToString:@"buy_pinduoduo"]) {
            APIUrl=@"mod=appapi&act=appPddGoodsDetail&ctrl=more_share";
        }else if ([self.SkipUIIdentifier isEqualToString:@"buy_jingdong"]){
            APIUrl=@"mod=appapi&act=appJdGoodsDetail&ctrl=more_share";
            params[@"yhq_url"]=self.yhq_url;
        }
        
        //@{@"fnuo_id":self.fnuo_id,@"getGoodsType":self.getGoodsType,TokenKey:UserAccessToken}]
        [FNRequestTool requestWithParams:params api:APIUrl respondType:(ResponseTypeModel) modelType:@"FNShareMutiplyModel" success:^(id respondsObject) {
            //
            [SVProgressHUD dismiss];
            self.model =respondsObject;
            if (self.model.goods_img.count>=1) {
                NSMutableArray* images = [NSMutableArray new];
                [self.model.goods_img enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    SMMImage* img = [SMMImage new];
                    img.image = obj;
                    [images addObject:img];
                }];
                self.model.images = images;
            }
            [self.refreshUI sendNext:nil];
            [subscriber sendCompleted];
        } failure:^(NSString *error) {
            
            //
            [self.refreshUI sendNext:nil];
            [subscriber sendCompleted];
        } isHideTips:YES isCache:NO];
        return nil;
    };
}

- (RACSubject *)shareSubject{
    if (_shareSubject == nil) {
        _shareSubject = [RACSubject subject];
    }
    return _shareSubject;
}
@end
