//
//  FNStoreGoodsSelectManagerController.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/16.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreManagerGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNStoreGoodsSelectManagerController;
@protocol FNStoreGoodsSelectManagerControllerDelegate <NSObject>


/**
 适用范围选择回调

 @param vc 当前viewcontroller
 @param cates 商品列表
 @param isAll 是否全场通用
 */
- (void)goodsSelectController: (FNStoreGoodsSelectManagerController*)vc cates: (NSArray<FNStoreManagerCateModel*> *)cates isAll: (BOOL)isAll;

@end

@interface FNStoreGoodsSelectManagerController : SuperViewController

@property (nonatomic, weak) id<FNStoreGoodsSelectManagerControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
