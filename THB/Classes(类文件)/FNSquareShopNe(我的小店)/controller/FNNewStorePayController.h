//
//  FNNewStorePayController.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/26.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNstoreInformationDaModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNNewStorePayController : SuperViewController

@property (nonatomic, copy) NSString *store_id;

- (void)setModel: (FNstoreInformationDaModel*)model;

@end

NS_ASSUME_NONNULL_END
