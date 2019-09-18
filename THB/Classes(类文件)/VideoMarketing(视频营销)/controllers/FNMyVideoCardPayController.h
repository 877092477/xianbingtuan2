//
//  FNMyVideoCardPayController.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNMyCardPayTypeModel.h"
#import "FNPayTypeChooseCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FNMyVideoCardPayControllerDelegate <NSObject>

- (void)didCardPay;

@end

@interface FNMyVideoCardPayController : SuperViewController

@property (nonatomic,strong)NSArray<FNMyCardPayTypeModel *> *PayModel;
@property (nonatomic,weak)id<FNMyVideoCardPayControllerDelegate> delegate;

@property (nonatomic, copy) NSString *cardId;
@property (nonatomic, assign) NSInteger count;
@end

NS_ASSUME_NONNULL_END
