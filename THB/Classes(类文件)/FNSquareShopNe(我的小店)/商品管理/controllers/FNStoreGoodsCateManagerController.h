//
//  FNStoreGoodsCateManagerController.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNStoreGoodsCateManagerController;
@protocol FNStoreGoodsCateManagerControllerDelegate<NSObject>

- (void)goodsCate: (FNStoreGoodsCateManagerController*)vc didSelected: (NSDictionary*) cate;

@end

@interface FNStoreGoodsCateManagerController : SuperViewController

@property (nonatomic, weak) id<FNStoreGoodsCateManagerControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
