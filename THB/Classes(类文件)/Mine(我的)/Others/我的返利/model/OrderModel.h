//
//  OrderModel.h
//  THB
//
//  Created by zhongxueyu on 16/4/21.
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

#import <Foundation/Foundation.h>

@interface OrderCateModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *SkipUIIdentifier;
@end

@interface OrderStatusModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *status;
@end


@interface OrderModel : FNBaseProductModel
@property (nonatomic, copy)NSString* hongbao_url;
@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *is_daozhang;

@property (nonatomic, copy) NSString *goodsId;

@property (nonatomic, copy) NSString *gid;


@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *orderType;



@property (nonatomic, copy) NSString *goodsInfo;

@property (nonatomic,copy) NSString *ads_name;



@property (nonatomic, copy) NSString *o_price;

@property (nonatomic, copy) NSString *fanli_time;

@property (nonatomic, copy) NSString *order_setstr1;

@property (nonatomic, copy) NSString *order_setstr2;

/**
 0 无 1确认收货后可抽奖 2立即抽奖 3获得
 */
@property (nonatomic, copy) NSString *choujiang_status;
@property (nonatomic, copy) NSString *payment;

@property (nonatomic, copy) NSString *SkipUIIdentifier;

@property (nonatomic, copy) NSString *fnuo_id;
@property (nonatomic, copy) NSString *getGoodsType;
@property (nonatomic, copy) NSString *goods_title;
@property (nonatomic, copy) NSString *shop_type;
@property (nonatomic, copy) NSString *jd;

@property (nonatomic, copy) NSString *label_str;
@property (nonatomic, copy) NSString *time_str;
@property (nonatomic, copy) NSString *order_str;

@property (nonatomic, copy) NSString *status_fontcolor;
@property (nonatomic, copy) NSString *status_color;

@property (nonatomic, copy) NSString *shop_type_color;
@property (nonatomic, copy) NSString *wl_btn;
@property (nonatomic, assign) NSInteger  is_show_wl;
@end

