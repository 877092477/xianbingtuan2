//
//  FNdisExTopUpController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FNdisExTopUpControllerDelegate <NSObject>
//充值完成
- (void)didDisExTopUpStateAction;
@end
@interface FNdisExTopUpController : SuperViewController
@property (nonatomic,strong)NSString *keyWord;
@property (nonatomic,weak) id<FNdisExTopUpControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
