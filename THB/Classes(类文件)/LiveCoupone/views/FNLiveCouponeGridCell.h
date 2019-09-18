//
//  FNLiveCouponeGridCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNComponentBaseCell.h"
#import "FNLiveCouponeSpecialView.h"
#import "Index_tuwenwei_01Model.h"
#import "MenuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNLiveCouponeGridCell : FNComponentBaseCell

/** 栅格（图文)视图 **/
@property (nonatomic, strong)FNLiveCouponeSpecialView* specialView;

/** 栅格视图背景 **/
@property (nonatomic, strong)UIImageView* specialbgimgview;


//图文位数组（index_tuwenwei_01）
@property (nonatomic, strong)NSArray<MenuModel *> *index_tuwenwei_01List;


@property (nonatomic, copy)void (^QuickClickedBlock)(MenuModel* model);
@end

NS_ASSUME_NONNULL_END
