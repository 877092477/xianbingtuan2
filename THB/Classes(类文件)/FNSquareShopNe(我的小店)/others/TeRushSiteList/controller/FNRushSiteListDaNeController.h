//
//  FNRushSiteListDaNeController.h
//  69橙子
//
//  Created by Jimmy on 2018/11/30.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
@protocol FNRushSiteListDaNeControllerDelegate <NSObject>
// 选择地址
- (void)siteListSelectAddressAction:(NSDictionary*)send;

@end
//NS_ASSUME_NONNULL_BEGIN

@interface FNRushSiteListDaNeController : SuperViewController
/** delegate **/
@property(nonatomic ,weak) id<FNRushSiteListDaNeControllerDelegate> delegate;
@end

//NS_ASSUME_NONNULL_END
