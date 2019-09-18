//
//  FNFunctionviewCell.h
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNComponentBaseCell.h"
#import "FNFunctionView.h"
#import "MenuModel.h"
#import "Index_kuaisurukou_01Model.h"

@interface FNFunctionviewCell : FNComponentBaseCell

@property (nonatomic, strong)FNFunctionView* functionview;//圆形按钮模块
/** 快速入口视图背景 **/
@property (nonatomic, strong)UIImageView* functionbgimgview;


#pragma mark- Block
@property (nonatomic, copy)void (^QuickClickedBlock)(MenuModel* model);

@property (nonatomic,strong) NSString *cateString;

-(void)setIndex_kuaisurukou_01List:(NSArray *)index_kuaisurukou_01List withColumn: (int)column;
@end
