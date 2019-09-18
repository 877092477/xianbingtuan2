//
//  FNStoreGoodsAttriManagerController.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreGoodsSpecManagerModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNStoreGoodsAttriManagerController;
@protocol FNStoreGoodsAttriManagerControllerDelegate <NSObject>

- (void)goodsAttri: (FNStoreGoodsAttriManagerController*)vc didSelected: (NSArray<FNStoreGoodsSpecManagerModel*>*) specs;

@end

@interface FNStoreGoodsAttriManagerController : SuperViewController

@property (nonatomic, strong) NSArray<FNStoreGoodsSpecManagerModel*> *baseSpecs;
@property (nonatomic, weak) id<FNStoreGoodsAttriManagerControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
