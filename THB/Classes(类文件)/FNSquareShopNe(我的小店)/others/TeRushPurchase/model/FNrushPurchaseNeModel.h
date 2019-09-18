//
//  FNrushPurchaseNeModel.h
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNStoreMyCouponeModel.h"

//NS_ASSUME_NONNULL_BEGIN

@interface FNrushPurchaseNeRedpackModel : NSObject
@property(nonatomic, copy) NSString     *str;
@property(nonatomic, copy) NSString     *discount_type;
@property(nonatomic, copy) NSString     *counts;
@property(nonatomic, copy) NSString     *counts_str;
@property(nonatomic, copy) NSString     *color;
@property(nonatomic, strong) NSArray<FNStoreMyCouponeModel*>     *list;
@end

@interface FNrushPurchaseNeModel : NSObject
@property(nonatomic, copy) NSString     *discount;
@property(nonatomic, copy) NSString     *sum;
@property(nonatomic, copy) NSArray     *cart;
@property(nonatomic, copy) NSString     *commission;
@property(nonatomic, copy) NSString     *fcommission;
@property(nonatomic, copy) NSString     *str;
@property(nonatomic, copy) NSString     *str1;
@property(nonatomic, copy) NSString     *phone;
@property(nonatomic, copy) NSString     *storename;
@property(nonatomic, copy) NSDictionary     *buy_msg;
@property(nonatomic, copy) NSArray     *pay_type;
@property(nonatomic, strong) NSArray<FNrushPurchaseNeRedpackModel*> *red_packets;

@end

//NS_ASSUME_NONNULL_END


@interface FNrushBuyTypeNeModel : NSObject
@property(nonatomic, copy) NSString     *str;
@property(nonatomic, copy) NSString     *type;
@end


@interface FNrushPurchCartNeModel : NSObject
@property(nonatomic, copy) NSString     *count;
@property(nonatomic, copy) NSString     *goods_price;
@property(nonatomic, copy) NSString     *goods_title;
@property(nonatomic, copy) NSString     *gid;
@property(nonatomic, copy) NSString     *goods_img;
@property(nonatomic, copy) NSString     *sum;
@property(nonatomic, copy) NSString     *type;
@property(nonatomic, copy) NSString     *str;
@property(nonatomic, copy) NSString     *color;
@property(nonatomic, copy) NSString     *font_color;
@property(nonatomic, copy) NSString     *str1;

@end

@interface FNrushBuyMsgModel : NSObject
@property(nonatomic, copy) NSString     *logo;
@property(nonatomic, copy) NSString     *address;
@property(nonatomic, copy) NSString     *phone;
@property(nonatomic, copy) NSString     *name;
@property(nonatomic, copy) NSString     *str;
@property(nonatomic, copy) NSString     *aid;
@property(nonatomic, copy) NSString     *code;
@property(nonatomic, copy) NSString     *qr_code;


@property(nonatomic, copy) NSString     *id;
@property(nonatomic, copy) NSString     *is_check;
@property(nonatomic, copy) NSString     *long_address; 
@property(nonatomic, assign) NSInteger     sex;
@property(nonatomic, copy) NSString     *lat;
@property(nonatomic, copy) NSString     *lng;
@property(nonatomic, copy) NSString     *is_peisong;

@end


