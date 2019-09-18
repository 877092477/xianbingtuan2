//
//  FNstoreInformationDaModel.h
//  69橙子
//
//  Created by Jimmy on 2018/11/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FNstoreCouponeModel : NSObject

@property(nonatomic, copy) NSString *id;
@property(nonatomic, copy) NSString *bj_img;
@property(nonatomic, copy) NSString *s_bj_img;
@property(nonatomic, copy) NSString *money;
@property(nonatomic, copy) NSString *money_str;
@property(nonatomic, copy) NSString *str;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *date;
@property(nonatomic, copy) NSString *btn;
@property(nonatomic, copy) NSString *color;
@property(nonatomic, copy) NSString *s_color;

@end

@interface FNstoreInformationCateModel : NSObject

@property(nonatomic, copy) NSString *id;
@property(nonatomic, copy) NSString *name;

@end

@interface FNstoreInformationDaModel : NSObject
@property(nonatomic, copy) NSString *id;
@property(nonatomic, copy) NSString *cid;
@property(nonatomic, copy) NSString *uid;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *img;
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *one_price;
@property(nonatomic, copy) NSString *commission;
@property(nonatomic, copy) NSString *lat;
@property(nonatomic, copy) NSString *lng;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *label_id;
@property(nonatomic, copy) NSString *bussiness_hours;
@property(nonatomic, copy) NSString *is_open;
@property(nonatomic, copy) NSString *ps_open;
@property(nonatomic, copy) NSString *postage_data;
@property(nonatomic, copy) NSString *district_id;
@property(nonatomic, copy) NSString *comment_counts;
@property(nonatomic, copy) NSString *comment_counts_str;
@property(nonatomic, copy) NSString *average_star;
@property(nonatomic, copy) NSString *good_star;
@property(nonatomic, copy) NSString *bad_star;
@property(nonatomic, copy) NSString *district_str;
@property(nonatomic, copy) NSString *open_time_str;
@property(nonatomic, copy) NSString *visitor;
@property(nonatomic, copy) NSString *can_buy;
@property(nonatomic, copy) NSString *open_str;
@property(nonatomic, copy) NSString *btn_str;
@property(nonatomic, copy) NSString *cart_price;
@property(nonatomic, copy) NSString *ps_price_str;
@property(nonatomic, copy) NSString *icon_location;
@property(nonatomic, copy) NSString *icon_phone;
@property(nonatomic, copy) NSString *map_icon;
@property(nonatomic, copy) NSString *store_icon;
@property(nonatomic, copy) NSString *bili;
@property(nonatomic, copy) NSString *distance1;
@property(nonatomic, copy) NSString *distance2;
@property(nonatomic, copy) NSString *distance;
@property(nonatomic, copy) NSString *end_commission;
@property(nonatomic, copy) NSString *str;
@property(nonatomic, copy) NSString *str2;
@property(nonatomic, copy) NSString *cate_str;
@property(nonatomic, copy) NSString *buy_str;
@property(nonatomic, copy) NSString *pay_str;
@property(nonatomic, copy) NSString *cart_count;
@property(nonatomic, copy) NSString *default_column;
@property(nonatomic, copy) NSString *redpacket_url;
@property(nonatomic, copy) NSString *redpacket_icon;

@property(nonatomic, strong) NSArray<FNstoreCouponeModel*> *yhq_list;
@property(nonatomic, copy) NSDictionary *fukuan;
@property(nonatomic, strong) NSArray<NSString*> *banner;

@property(nonatomic, strong) NSArray<NSString*> *album_list;
@property(nonatomic, strong) NSArray *tab;


@property(nonatomic, strong) NSArray    *btn;
@property(nonatomic, strong) NSArray<FNstoreInformationCateModel*>    *cates;

@end



@interface FNstoreBtnItemModel : NSObject
@property(nonatomic, copy) NSString     *type;
@property(nonatomic, copy) NSString     *bg_color;
@property(nonatomic, copy) NSString     *font_color;
@property(nonatomic, copy) NSString     *str;
@property(nonatomic, assign) NSInteger     is_show;
 
@end
