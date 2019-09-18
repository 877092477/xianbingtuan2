//
//  FNStoreGoodsAttriEditManagerController.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/15.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNStoreGoodsAttriEditManagerController;
@protocol FNStoreGoodsAttriEditManagerControllerDelegate <NSObject>

- (void)onSave:(FNStoreGoodsAttriEditManagerController*)vc;

@end

@interface FNStoreGoodsAttriEditManagerController : SuperViewController

@property (nonatomic, weak) id<FNStoreGoodsAttriEditManagerControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
