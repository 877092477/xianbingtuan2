//
//  FNLiveCouponeStoreCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNComponentBaseCell.h"
#import "MenuModel.h"
#import "Index_kuaisurukou_01Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNLiveCouponeStoreCell : FNComponentBaseCell

/** 快速入口视图背景 **/
@property (nonatomic, strong)UIImageView* functionbgimgview;


#pragma mark- Block
@property (nonatomic, copy)void (^QuickClickedBlock)(MenuModel* model);

-(void)setIndex_store_01List:(NSArray *)index_store_01List withColumn: (int)column;

@end

NS_ASSUME_NONNULL_END
