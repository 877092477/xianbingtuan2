//
//  FNBrandDetailController.h
//  THB
//
//  Created by jimmy on 2017/5/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
@class FNBrandShopModel;
@interface FNBrandDetailController : SuperViewController
@property (nonatomic, strong)FNBrandShopModel* model;
@property (nonatomic, copy)NSString* dp_type;
@end
