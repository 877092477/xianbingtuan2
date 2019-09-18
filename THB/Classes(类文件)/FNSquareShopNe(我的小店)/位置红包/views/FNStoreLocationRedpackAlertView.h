//
//  FNStoreLocationRedpackAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/23.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreLocationRedpackModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RedpackClickBlcok) ();//回调

@interface FNStoreLocationRedpackAlertView : UIView

- (void)showModel: (FNStoreLocationRedpackDetailModel*)model block: (RedpackClickBlcok)block;

- (void)dismiss ;

@end

NS_ASSUME_NONNULL_END
