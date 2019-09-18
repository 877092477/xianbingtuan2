//
//  FNmerElseSetingsController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNmerSetingsModel.h"
@protocol FNmerElseSetingsControllerDelegate <NSObject>
// 修改完成
- (void)inDidMerElseSetingsAction;
- (void)inDidMerElseSetingsBackWithcontent:(NSString*)content withType:(NSString*)keyType;
@end
NS_ASSUME_NONNULL_BEGIN

@interface FNmerElseSetingsController : SuperViewController
@property (nonatomic,strong)NSString *keyWord;//money:更改赏金比例  phone:更改电话  name:更改店铺名称  date:修改时间
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSDictionary *contentDic;
//营业时间的参数【bussiness_day 日期，start_time开始时间，end_time 结束时间】
@property (nonatomic, strong)FNmerSetingsModel *dataModel;
@property (nonatomic, weak)id<FNmerElseSetingsControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
