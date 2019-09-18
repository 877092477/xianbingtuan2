//
//  ALBBDetailsViewController.h
//  Top61
//
//  Created by zhongxueyu on 16/7/6.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
@interface ALBBDetailsViewController : SuperViewController
@property(nonatomic,strong)NSString *titleName;

@property(nonatomic,strong)NSString *comFrom;

/** 用来记录浏览足迹的 **/
@property(nonatomic,strong)NSString *goodsId;

/** 发给百川打开的 **/
@property(nonatomic,strong)NSString *fnuoId;

/** 发给百川打开的 **/
@property(nonatomic,strong)NSString *highcommission_url;

@end
