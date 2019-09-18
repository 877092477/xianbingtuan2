//
//  FNConnectionsHomeModel.h
//  THB
//
//  Created by Weller Zhao on 2019/1/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNConnectionsGroupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNConnectionsHomeTopIconModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *font_color;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *SkipUIIdentifier;
@property (nonatomic, copy) NSString *ktype;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *UIIdentifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *view_type;
@property (nonatomic, copy) NSString *goodslist_img;
@property (nonatomic, copy) NSString *goodslist_str;
@property (nonatomic, copy) NSString *goods_detail;
@property (nonatomic, copy) NSString *is_need_login;
@property (nonatomic, copy) NSString *integral_id;
@property (nonatomic, copy) NSString *fnuo_id;
@property (nonatomic, copy) NSString *shop_type;
@property (nonatomic, copy) NSString *start_price;
@property (nonatomic, copy) NSString *end_price;
@property (nonatomic, copy) NSString *commission;
@property (nonatomic, copy) NSString *goods_sales;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *yhq_onoff;
@property (nonatomic, copy) NSString *goods_pd_onoff;
@property (nonatomic, copy) NSString *dtk_goods_onoff;
@property (nonatomic, copy) NSString *show_type_str;
@property (nonatomic, copy) NSString *goods_type_name;
@property (nonatomic, copy) NSString *getGoodsType;
@property (nonatomic, copy) NSString *goods_msg;
@property (nonatomic, copy) NSString *goods_title;
@property (nonatomic, copy) NSString *goodsInfo;
@property (nonatomic, copy) NSString *show_name;
@property (nonatomic, copy) NSString *is_new;
@property (nonatomic, copy) NSString *count;

@end

@interface FNConnectionsHomeTopModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *font_color;
@property (nonatomic, copy) NSString *bg_img;
@property (nonatomic, copy) NSString *list_bgimg;
@property (nonatomic, copy) NSString *search_img;
@property (nonatomic, copy) NSString *scan_img;
@property (nonatomic, copy) NSString *return_img;
@property (nonatomic, strong) NSArray<FNConnectionsHomeTopIconModel*> *list;

@end

@interface FNConnectionsHomeServiceItemModel : NSObject

@property (nonatomic, copy) NSString* group_id;
@property (nonatomic, copy) NSString* uid;
@property (nonatomic, copy) NSString* is_group;
@property (nonatomic, copy) NSString* head_img;
@property (nonatomic, copy) NSString* nickname;
@property (nonatomic, copy) NSString* content;

@end

@interface FNConnectionsHomeContactModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* is_show;
@property (nonatomic, strong) NSArray<FNConnectionsHomeServiceItemModel*>* list;

@end

@interface FNConnectionsHomeGroupModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* is_show;
@property (nonatomic, strong) NSArray<FNConnectionsGroupModel*>* list;

@end

@interface FNConnectionsHomeModel : NSObject

@property (nonatomic, strong) FNConnectionsHomeTopModel *top;
@property (nonatomic, strong) FNConnectionsHomeContactModel *custom_service;
@property (nonatomic, strong) FNConnectionsHomeGroupModel *group;
@property (nonatomic, strong) NSArray<NSString*> *ABC;
@property (nonatomic, copy) NSString *friend_str;

@end

NS_ASSUME_NONNULL_END
