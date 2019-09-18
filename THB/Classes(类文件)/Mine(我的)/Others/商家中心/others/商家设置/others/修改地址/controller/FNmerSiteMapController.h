//
//  FNmerSiteMapController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
@protocol FNmerSiteMapControllerDelegate <NSObject>
// 返回地址
- (void)didMerSiteMapBackAction:(id)addressModel;

@end
NS_ASSUME_NONNULL_BEGIN

@interface FNmerSiteMapController : SuperViewController
@property (nonatomic, weak)id<FNmerSiteMapControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
