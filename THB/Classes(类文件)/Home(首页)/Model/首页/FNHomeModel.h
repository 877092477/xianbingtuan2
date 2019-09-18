//
//  FNHomeModel.h
//  THB
//
//  Created by zhongxueyu on 2018/8/17.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Index_topnav_01Model.h"
#import "Index_huandengpian_01Model.h"
#import "Index_kuaisurukou_01Model.h"
#import "Index_threemodel_01Model.h"
#import "Index_paomadeng_01Model.h"
#import "Index_miaosha_01Model.h"
#import "Index_tuwenwei_01Model.h"
#import "Index_goods_01Model.h"
#import "MenuModel.h"


@class Index_topnav_01Model;
@class Index_huandengpian_01Model;
@class Index_kuaisurukou_01Model;
@class Index_threemodel_01Model;
@class Index_paomadeng_01Model;
@class Index_miaosha_01Model;
@class Index_tuwenwei_01Model;
@class Index_goods_01Model;
@class MenuModel;


@interface FNHomeModel : NSObject
#pragma mark- 外层字段
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * jiange;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * mac;

@property (nonatomic, strong)NSMutableArray* jiangeArr;//保存每个模块下间隔

@property (nonatomic, strong)NSMutableArray* TypeArr;//保存模块位置0为首位

@property (nonatomic, strong)NSMutableDictionary* TypeDic;//保存每个模块对应的页面


#pragma mark- ListModel
//页头部搜索栏数组（index_topnav_01）
@property (nonatomic, strong)NSArray* index_topnav_01List;
@property (nonatomic, strong)NSString* end_color;

//轮播图数组（index_huandengpian_01）
@property (nonatomic, strong)NSArray* index_huandengpian_01List;
@property (nonatomic, strong)NSArray* index_huandengpian_02List;

//快速入口数据数组（index_kuaisurukou_01）
@property (nonatomic, strong)NSArray *index_kuaisurukou_01List;
@property (nonatomic, strong)RACSubject* kuaisurukouSubject;


//首页第三模块广告位(index_threemodel_01)
@property (nonatomic, strong)NSArray *index_threemodel_01List;


//首页跑马灯（index_paomadeng_01）
@property (nonatomic, strong)NSMutableArray* index_paomadeng_01List;

//今日秒杀（index_miaosha_01）
@property (nonatomic, strong)Index_miaosha_01Model* index_miaosha_01;

//图文位数组（index_tuwenwei_01）
@property (nonatomic, strong)NSArray<MenuModel *> *index_tuwenwei_01List;


//首页商品（index_goods_01）
@property (nonatomic, strong)NSArray* index_goods_01List;



@end
