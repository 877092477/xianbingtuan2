//
//  ProductCVViewController.h
//  THB
//
//  Created by zhongxueyu on 16/3/21.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import <UIKit/UIKit.h>
#import "secondViewController.h"
#import "ALBBDetailsViewController.h"
@interface ProductCVViewController : SuperViewController
@property (nonatomic,strong) NSNumber *categoryId;

/** 是否来自首页 */
@property (nonatomic,assign) int fromHome;

/** 产品类型(1.超高返,2.9块9) */
@property (nonatomic,assign) int type;

/**搜索的内容 */
@property (nonatomic,strong) NSString *searchTitle;

/**排序条件（1.最新,2.最热) */
@property (nonatomic,assign) NSNumber *sort;

/**最低价格 */
@property (nonatomic,assign) int price1;

/**最高价格*/
@property (nonatomic,assign) int price2;

@property (nonatomic, copy)NSString* cid;

@property (nonatomic, copy)NSString* skipUIIdentifier;
@end
