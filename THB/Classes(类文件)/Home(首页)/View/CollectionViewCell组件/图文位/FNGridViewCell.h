//
//  FNGridViewCell.h
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNComponentBaseCell.h"
#import "FNHomeSpecialView.h"
#import "Index_tuwenwei_01Model.h"
#import "MenuModel.h"

@interface FNGridViewCell : FNComponentBaseCell

/** 栅格（图文)视图 **/
@property (nonatomic, strong)FNHomeSpecialView* specialView;

/** 栅格视图背景 **/
@property (nonatomic, strong)UIImageView* specialbgimgview;


//图文位数组（index_tuwenwei_01）
@property (nonatomic, strong)NSArray<MenuModel *> *index_tuwenwei_01List;


@property (nonatomic, copy)void (^QuickClickedBlock)(MenuModel* model);

@end
