//
//  FNUpOrderMessageNeController.h
//  THB
//
//  Created by Jimmy on 2018/9/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

@interface FNUpOrderMessageNeController : SuperViewController

//** 商品ID **/
@property (nonatomic,strong)NSString *commodityID;
//** 购买数量 **/
@property (nonatomic,strong)NSString *numString;
//** 属性分类 多个逗号隔开 没有可不传 **/
@property (nonatomic,strong)NSString *attr_idString;
@end
