//
//  FNdisExchangeItemController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "JXCategoryListContainerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNdisExchangeItemController : SuperViewController<JXCategoryListContentViewDelegate>
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)UINavigationController *naviController; 
@property (nonatomic,strong)NSString *updaState;
@end

NS_ASSUME_NONNULL_END
