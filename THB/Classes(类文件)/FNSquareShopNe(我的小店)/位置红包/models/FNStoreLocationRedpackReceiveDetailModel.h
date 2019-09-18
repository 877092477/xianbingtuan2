//
//  FNStoreLocationRedpackReceiveDetailModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/28.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreLocationRedpackDetailLabelModel : NSObject

@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* color;

@end

@interface FNStoreLocationRedpackDetailRedpackModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* bjimg;
@property (nonatomic, copy) NSString* price;
@property (nonatomic, copy) NSString* full_str;
@property (nonatomic, copy) NSString* time_str;
@property (nonatomic, copy) NSString* day_str;
@property (nonatomic, copy) NSString* color;
@property (nonatomic, copy) NSString* price_color;
@property (nonatomic, copy) NSString* info_color;
@property (nonatomic, copy) NSString* time_color;
@property (nonatomic, copy) NSString* info;
@property (nonatomic, copy) NSString* btnimg;
@property (nonatomic, copy) NSString* is_receive;
@property (nonatomic, copy) NSString* c_str;
@property (nonatomic, copy) NSString* r_str;

@end

@interface FNStoreLocationRedpackDetailStoreModel : NSObject

@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* store_name;
@property (nonatomic, copy) NSString* store_id;
@property (nonatomic, copy) NSString* lat;
@property (nonatomic, copy) NSString* lng;
@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* bjcolor;
@property (nonatomic, copy) NSString* fontcolor;

@property (nonatomic, strong) NSArray* cate;

@end

@interface FNStoreLocationRedpackDetailRedpackTotalModel : NSObject

@property (nonatomic, copy) NSString* str;
@property (nonatomic, strong) NSArray<NSString*>* user_list;
@property (nonatomic, copy) NSString* btn_str;
@property (nonatomic, copy) NSString* btn_color;

@end

@interface FNStoreLocationRedpackDetailAvdModel : NSObject

@property (nonatomic, copy) NSString* adv_img;
@property (nonatomic, copy) NSString* adv_url;
@property (nonatomic, copy) NSString* adv_seconds;
@property (nonatomic, copy) NSString* adv_seconds_color;
@property (nonatomic, copy) NSString* is_advertising;

@end

@interface FNStoreLocationRedpackReceiveDetailModel : NSObject

@property (nonatomic, copy) NSString* bjimg;
@property (nonatomic, copy) NSString* return_img;
@property (nonatomic, copy) NSString* top_title_color;
@property (nonatomic, copy) NSString* top_title;
@property (nonatomic, copy) NSString* store_id;
@property (nonatomic, copy) NSString* rid;
@property (nonatomic, copy) NSString* store_name;
@property (nonatomic, copy) NSString* store_img;
@property (nonatomic, copy) NSString* store_name_color;
@property (nonatomic, strong) NSArray<FNStoreLocationRedpackDetailLabelModel*>* label;

@property (nonatomic, strong) FNStoreLocationRedpackDetailRedpackModel *packet;
@property (nonatomic, strong) FNStoreLocationRedpackDetailStoreModel* redpacket_store_msg;
@property (nonatomic, strong) FNStoreLocationRedpackDetailRedpackTotalModel *packet_total;
@property (nonatomic, strong) FNStoreLocationRedpackDetailStoreModel *store;
@property (nonatomic, strong) FNStoreLocationRedpackDetailAvdModel *adv_data;


@end

NS_ASSUME_NONNULL_END
