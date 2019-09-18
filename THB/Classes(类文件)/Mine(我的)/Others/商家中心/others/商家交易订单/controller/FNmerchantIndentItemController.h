//
//  FNmerchantIndentItemController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "JXCategoryListContainerView.h"
#import "FNmerchantIndentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerchantIndentItemController : SuperViewController<JXCategoryListContentViewDelegate>
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)FNmerchantIndentModel *indentModel;
@property (nonatomic,strong)UINavigationController *naviController; 
@end

NS_ASSUME_NONNULL_END
