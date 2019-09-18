//
//  FNSlideBarViewCell.h
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNComponentBaseCell.h"
#import "FDSlideBar.h"
#import "Index_goods_01Model.h"
@interface FNSlideBarViewCell : FNComponentBaseCell
/** 商品分栏视图 **/
@property (nonatomic, strong)UIView* slideBarView;

@property (nonatomic, strong)FDSlideBar *slideBar;//分栏内容

//首页商品（index_goods_01）
@property (nonatomic, strong)NSArray* index_goods_01List;

@property (nonatomic, copy)void (^ColumnClickedBlock)(Index_goods_01Model* model);

@property (nonatomic, copy)void (^ColumnClickedAddIntBlock)(Index_goods_01Model* model,NSInteger indexing);

@property (nonatomic, assign)NSInteger storeindex;

@end
