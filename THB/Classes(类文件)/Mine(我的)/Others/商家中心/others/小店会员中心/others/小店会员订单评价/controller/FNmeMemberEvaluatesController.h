//
//  FNmeMemberEvaluatesController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNmerchentReviewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmeMemberEvaluatesController : SuperViewController
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *store_id;
@property(nonatomic,strong)NSString *isAmend;
@property(nonatomic,strong)FNmerchentReviewModel *amendModel;
@property (nonatomic, copy)void (^inMeMemberEvaluatesRefreshData)(void);
@end

NS_ASSUME_NONNULL_END
