//
//  FNDetailShopController.h
//  THB
//
//  Created by Jimmy on 2017/12/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
@class JM_NPD_dpArr;
@interface FNDetailShopController : SuperViewController
@property (nonatomic, strong)JM_NPD_dpArr* model;
@property (nonatomic, copy)NSString* fnuo_id;
@property (nonatomic, copy)NSString* f_shopurl;
@end
