//
//  FNshopTendOptionsNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/11/22.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "FNFunctionView.h"
#import "MenuModel.h"
#import "Index_kuaisurukou_01Model.h"

@protocol FNshopTendOptionsNeCellDelegate <NSObject>
// 点击分类
- (void)tendOptionsAction:(NSInteger)sender;

@end

@interface FNshopTendOptionsNeCell : UICollectionViewCell

@property (nonatomic, strong)FNFunctionView* functionview;//圆形按钮模块
/** 快速入口视图背景 **/
@property (nonatomic, strong)UIImageView* functionbgimgview;
//快速入口数据数组（index_kuaisurukou_01）
@property (nonatomic, strong)NSArray *kuaisurukouList;

@property(nonatomic ,weak) id<FNshopTendOptionsNeCellDelegate> delegate;

@end


