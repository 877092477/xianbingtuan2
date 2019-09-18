//
//  FNMineModel.h
//  THB
//
//  Created by Weller Zhao on 2018/12/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FNMineDataModel;
@interface FNMineModel : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *mac;
@property (nonatomic, copy) NSString *jiange;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<FNMineDataModel*> *list;

@property (nonatomic, strong) NSArray<UIImage*> *images;

@end

@interface FNMineIncomeModel : NSObject

@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *color;

@end

@interface FNMineDataModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *SkipUIIdentifier;
@property (nonatomic, copy) NSString *yhq_price;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSString *search_keyword;
@property (nonatomic, copy) NSString *dtk_goods_onoff;
@property (nonatomic, copy) NSString *fnuo_id;
@property (nonatomic, copy) NSString *shop_type;
@property (nonatomic, copy) NSString *goods_pd_onoff;
@property (nonatomic, copy) NSString *jdgoods_pd_onoff;
@property (nonatomic, copy) NSString *yhq_onoff;
@property (nonatomic, copy) NSString *start_price;
@property (nonatomic, copy) NSString *end_price;
@property (nonatomic, copy) NSString *goods_sales;
@property (nonatomic, copy) NSString *commission;
@property (nonatomic, copy) NSString *show_type_str;
@property (nonatomic, copy) NSString *double_bjimg;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *UIIdentifier;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *goodslist_img;
@property (nonatomic, copy) NSString *goodslist_str;
@property (nonatomic, copy) NSString *view_type;
@property (nonatomic, copy) NSString *is_showcate;
@property (nonatomic, strong) NSArray *goods_detail;

@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *goods_type_name;
@property (nonatomic, copy) NSString *getGoodsType;
@property (nonatomic, strong) NSArray *goods_msg;

@property (nonatomic, copy) NSString *goodsInfo;
@property (nonatomic, copy) NSString *font_color;
@property (nonatomic, copy) NSString *show_name;

@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *tx_money;
@property (nonatomic, copy) NSString *tx_moneycolor;
@property (nonatomic, copy) NSString *str1;
@property (nonatomic, copy) NSString *tx_str;
@property (nonatomic, copy) NSString *is_tx;
@property (nonatomic, copy) NSString *tx_color;
@property (nonatomic, copy) NSString *tx_bjcolor;
@property (nonatomic, copy) NSString *extend_color;
@property (nonatomic, copy) NSString *fan_color;
@property (nonatomic, copy) NSString *fan_str;
@property (nonatomic, copy) NSString *fan_num;
@property (nonatomic, copy) NSString *extend_str;
@property (nonatomic, copy) NSString *extend_num;
@property (nonatomic, copy) NSString *yg_str;
@property (nonatomic, copy) NSString *yg_num;
@property (nonatomic, copy) NSString *agent_str;
@property (nonatomic, copy) NSString *agent_num;
@property (nonatomic, copy) NSString *yg_color;
@property (nonatomic, copy) NSString *agent_color;
@property (nonatomic, copy) NSString *bj_img;

@property (nonatomic, copy) NSString *is_need_login;
@property (nonatomic, copy) NSString *is_can_bind;
@property (nonatomic, copy) NSString *tip_str;
@property (nonatomic, copy) NSString *tip_content;

@property (nonatomic, copy) NSString *jsonInfo;

@property (nonatomic, strong) NSArray<FNMineIncomeModel*> *income_list;
@end

NS_ASSUME_NONNULL_END
