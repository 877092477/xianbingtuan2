//
//  ProductListViewController.h
//  THB
//
//  Created by zhongxueyu on 16/3/31.
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
#import "SuperViewController.h"
#import "UIView+KRKit.h"
#import "ALBBDetailsViewController.h"
@interface ProductListViewController : SuperViewController

{
    int a;
}

/**搜索的内容 */
@property (nonatomic,copy) NSString *searchTitle;

/**分类ID*/
@property (nonatomic,assign) NSString *categoryID;

/**排序条件 */
@property (nonatomic,assign) int sort;

/**最低价格 */
@property (nonatomic,assign) int price1;

/**最高价格*/
@property (nonatomic,assign) int price2;

/** 从搜索页面跳转 */
@property (nonatomic,assign) int type;


@end
