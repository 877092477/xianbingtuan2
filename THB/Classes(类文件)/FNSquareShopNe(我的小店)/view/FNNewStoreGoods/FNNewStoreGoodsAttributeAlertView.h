//
//  FNNewStoreGoodsAttributeAlertView.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/31.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNNewStoreGoodsAttributeAlertView;
@protocol FNNewStoreGoodsAttributeAlertViewDelegate <NSObject>

- (void)attributeAlertDidClick:(NSString*)count specs: (NSString*)specs withKeys: (NSArray<NSString*>*)keys;

@end

@interface FNNewStoreGoodsAttributeAlertView : UIView

@property (nonatomic, weak) id<FNNewStoreGoodsAttributeAlertViewDelegate> delegate;

- (void)setModel: (FNStoreGoodsModel*) model;
- (void)show ;
- (void)dismiss ;

@end

NS_ASSUME_NONNULL_END
